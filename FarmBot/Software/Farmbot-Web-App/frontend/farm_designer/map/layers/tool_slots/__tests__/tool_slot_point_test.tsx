import * as React from "react";
import { ToolSlotPoint, TSPProps } from "../tool_slot_point";
import {
  fakeToolSlot, fakeTool
} from "../../../../../__test_support__/fake_state/resources";
import {
  fakeMapTransformProps
} from "../../../../../__test_support__/map_transform_props";
import { svgMount } from "../../../../../__test_support__/svg_mount";

describe("<ToolSlotPoint/>", () => {
  const fakeProps = (): TSPProps => ({
    mapTransformProps: fakeMapTransformProps(),
    botPositionX: undefined,
    slot: { toolSlot: fakeToolSlot(), tool: fakeTool() }
  });

  const testToolSlotGraphics = (tool: 0 | 1, slot: 0 | 1) => {
    it(`renders ${tool ? "" : "no"} tool and ${slot ? "" : "no"} slot`, () => {
      if (!tool && !slot) { tool = 1; }
      const p = fakeProps();
      if (!tool) { p.slot.tool = undefined; }
      p.slot.toolSlot.body.pullout_direction = slot;
      const wrapper = svgMount(<ToolSlotPoint {...p} />);
      expect(wrapper.find("circle").length).toEqual(tool);
      expect(wrapper.find("use").length).toEqual(slot);
    });
  };
  testToolSlotGraphics(0, 0);
  testToolSlotGraphics(0, 1);
  testToolSlotGraphics(1, 0);
  testToolSlotGraphics(1, 1);

  it("displays tool name", () => {
    const p = fakeProps();
    p.slot.toolSlot.body.pullout_direction = 2;
    const wrapper = svgMount(<ToolSlotPoint {...p} />);
    wrapper.find(ToolSlotPoint).setState({ hovered: true });
    expect(wrapper.find("text").props().visibility).toEqual("visible");
    expect(wrapper.find("text").text()).toEqual("Foo");
    expect(wrapper.find("text").props().dx).toEqual(-40);
  });

  it("displays 'no tool'", () => {
    const p = fakeProps();
    p.slot.tool = undefined;
    const wrapper = svgMount(<ToolSlotPoint {...p} />);
    wrapper.find(ToolSlotPoint).setState({ hovered: true });
    expect(wrapper.find("text").text()).toEqual("no tool");
    expect(wrapper.find("text").props().dx).toEqual(40);
  });

  it("doesn't display tool name", () => {
    const wrapper = svgMount(<ToolSlotPoint {...fakeProps()} />);
    expect(wrapper.find("text").props().visibility).toEqual("hidden");
  });

  it("renders bin", () => {
    const p = fakeProps();
    if (p.slot.tool) { p.slot.tool.body.name = "seed bin"; }
    const wrapper = svgMount(<ToolSlotPoint {...p} />);
    expect(wrapper.find("#SeedBinGradient").length).toEqual(1);
  });

  it("renders tray", () => {
    const p = fakeProps();
    if (p.slot.tool) { p.slot.tool.body.name = "seed tray"; }
    const wrapper = svgMount(<ToolSlotPoint {...p} />);
    expect(wrapper.find("#SeedTrayPattern").length).toEqual(1);
  });

  it("renders trough", () => {
    const p = fakeProps();
    p.slot.toolSlot.body.gantry_mounted = true;
    if (p.slot.tool) { p.slot.tool.body.name = "seed trough"; }
    const wrapper = svgMount(<ToolSlotPoint {...p} />);
    expect(wrapper.find("#seed-trough").length).toEqual(1);
  });

  it("sets hover", () => {
    const wrapper = svgMount(<ToolSlotPoint {...fakeProps()} />);
    expect(wrapper.find(ToolSlotPoint).state().hovered).toBeFalsy();
    (wrapper.find(ToolSlotPoint).instance() as ToolSlotPoint).setHover(true);
    expect(wrapper.find(ToolSlotPoint).state().hovered).toBeTruthy();
  });
});
