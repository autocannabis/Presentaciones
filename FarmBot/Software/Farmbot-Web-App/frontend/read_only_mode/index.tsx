import { AxiosRequestConfig } from "axios";
import { store } from "../redux/store";
import { warning } from "../toast/toast";
import React from "react";
import { appIsReadonly } from "./app_is_read_only";

export const readOnlyInterceptor = (config: AxiosRequestConfig) => {
  const method = (config.method || "get").toLowerCase();
  const relevant = ["put", "patch", "delete"].includes(method);

  if (relevant && appIsReadonly(store.getState().resources.index)) {
    if (!(config.url || "").includes("web_app_config")) {
      warning("Refusing to modify data in read-only mode");
      return Promise.reject(config);
    }
  }

  return Promise.resolve(config);
};

const MOVE_ME_ELSEWHERE: React.CSSProperties = {
  float: "right",
  boxSizing: "inherit",
  margin: "9px 0px 0px 9px"
};

export const ReadOnlyIcon = (p: { locked: boolean }) => {
  if (p.locked) {
    return <div className="fa-stack fa-lg" style={MOVE_ME_ELSEWHERE}>
      <i className="fa fa-pencil fa-stack-1x"></i>
      <i className="fa fa-ban fa-stack-2x fa-rotate-90 text-danger"></i>
    </div>;

  } else {
    return <div />;
  }
};
