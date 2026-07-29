En el presente proyecto se analiza el problema de rotación de personal que presenta IBM desde dos perspectivas:

1.- Ciencia de datos: Dónde a partir de algoritmos de machine learning se hace la predicción de de que tipos de colaboradores son los propensos a irse. Eso se encuentra en el archivo ".ipynb".

2.- Análisis de Inteligencia de negocios: Cómo complemento al proyecto de ciencia de datos, se anexa también un tablero de Power BI, dónde puede ver la estadística descriptiva de la data, además de los KPI´s principales.


-Toda la investigación se desarrolló durante el punto 1 , en el archivo ".ipynb".

- Posteriormente se normalizó la data en seis tablas, las cuales se almacenaron en un gestor de base de datos (MySQL).

- Posteriormente, el modelado se realizó en el gestor de base de datos, no se hizo en Power BI, esto con la finalidad de hacer más eficiente el dashboard final, ya que el motor de Power Bi no se encargará de modelar la data, sino el gestor de base de datos, ya que para eso está optiomizado.

- Una vez modelada la data, a través de una vista de SQL, se conectó Power BI al gestor de Base de Datos solo para visualizar la información a través del dashboard.
