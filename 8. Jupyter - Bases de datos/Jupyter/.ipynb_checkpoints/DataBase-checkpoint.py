import sqlite3 as sql
import os
class DB():
	"""
		Crea y organiza la base de datos.
	"""
	def __init__(self, local, ElType):
		#Borrar tablas existentes
		try:
			try:
				os.remove('data.db')
			except:
				os.remove('App/Preprocessing/data.db')
		except:
			pass
		#Creación de la base de datos
		if local:
			self.con = sql.connect('data.db')
		else:
			self.con = sql.connect('App/Preprocessing/data.db')
		self.cursor = self.con.cursor()
		#Crear tablas
		self.Tabla_Nodos()
		self.Tabla_Elementos(ElType)

	def Tabla_Nodos(self):
		self.cursor.execute("""
			CREATE TABLE nodes (
				NodeID int,
				x float,
				y float
			)
			""")
		self.con.commit()

	def Tabla_Elementos(self, ElType):
		text = "CREATE TABLE elements (ElID int, "
		digit = 0
		for i in range(len(ElType), -1, -1):
			try:
				int(ElType[i])
				digit += 1
			except:
				pass
		for i in range(int(ElType[-digit:])):
			if i < int(ElType[-digit:])-1:
				char = ','
			else:
				char = ''
			text += 'Node' + str(i+1) + char
		text += ')'

		self.cursor.execute(text)
		self.con.commit()

if __name__ == '__main__':
	DB(local=True, ElType='Cuad4')