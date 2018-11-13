# RappiMovies
iOS project with clean-swift architecture


## Capas de aplicación:

### Capa de vistas: 

Es la capa que contiene las vistas que se presentan al usuario.

####  Clases contenidas en `CustomViews`:

`DetailView.swift`, `MovieCell.swift`, `MoviesView.swift`, `PlaceholderCell.swift`
        
  ### Capa de presentación: 
  
  La capa de presentación está formada por la lógica que contiene la aplicación, se encarga de la gestión de datos para ser presentados a los usuarios en la capa de vistas.
  
  ####  Clases:
  
  `MainMoviesViewController.swift`, `MainMoviesPresenter.swift`, `MovieDetailPresenter.swift`, `MovieDetailViewController.swift`
  
### Capa de negocio (Interactors): 

Contiene la lógica de negocio, encargado de qué debe hacer la aplicación.

####  Clases:

`MovieDetailModels.swift`, `MainMoviesModels.swift`, `MovieDetailInteractor.swift`, `MainMoviesInteractor.swift`, `MainMoviesWorker.swift`, `MainMoviesRouter.swift`, `MovieDetailWorker.swift`, `MovieDetailRouter.swift`, `MovieModel.swift` 

###  Capa de datos: 

Es la capa en donde se obtienen todos los datos que necesita nuestra aplicación para funcionar y los datos pueden ser de proveídos por un servicio web o almacenados localmente.

####  Clases:

`Services.swift` 


## Responsabilidad de clases:

`MoviesView.swift`  : La clase es la encargada de la creación de la vista principal en la que se listan las películas.
`DetailView.swift`  : La clase es la encargada de la creación de la vista de detalle de la película seleccionada.
`MovieCell.swift`  : La clase es la encargada de la creación de la vista de cada celda que se presenta en la lista de películas.
`PlaceholderCell.swift`  : La clase es la encargada de la creación de la vista de cada celda que se presenta mientras se cargan los datos del servicio web.

`Extensions.swift`  : La clase es la encargada de la extensión de funciones comunes de tipos de datos.

`MovieModel.swift`  : La clase es la encargada de contener la estructura y tipos de datos del modelo película.

`NetworkServices.swift`  : La clase es la encargada de verificar si hay acceso a internet.
`Services.swift`  : La clase es la encargada de realizar las peticiones que se realizan al servicio web.

`MainMoviesPresenter.swift`  : La clase es la encargada de recibir datos y enviarlos al viewcontroller.
`MainMoviesWorker.swift`  : La clase es la encargada de comunicarse con la clase Services.swift para retornar los datos que se traen del servicio web.
`MainMoviesRouter.swift`  : La clase es la encargada de manejar la navegación y el paso de datos a otros viewcontrollers.
`MainMoviesModels.swift`  :  La clase es la encarga de contener los casos de uso, es decir, cuando se tiene que coordinar una acción requerida por el usuario.
`MainMoviesViewController.swift`  :   La clase es la encargada de enviar los configurar la vista.
`MainMoviesInteractor.swift`  : La clase es la encargada de recibir los request del viewcontroller, ordenar al worker los datos y enviarlos al presenter.

`MovieDetailPresenter.swift`  : La clase es la encargada de recibir datos y enviarlos al viewcontroller.
`MovieDetailWorker.swift`  : La clase es la encargada de comunicarse con la clase Services.swift para retornar los datos que se traen del servicio web.
`MovieDetailRouter.swift`  : La clase es la encargada de manejar la navegación y el paso de datos a otros viewcontrollers.
`MovieDetailModels.swift`  :  La clase es la encarga de contener los casos de uso, es decir, cuando se tiene que coordinar una acción requerida por el usuario.
`MovieDetailViewController.swift`  :   La clase es la encargada de enviar los configurar la vista.
`MovieDetailInteractor.swift`  : La clase es la encargada de recibir los request del viewcontroller, ordenar al worker los datos y enviarlos al presenter.

`RappiMoviesTestsInteractor.swift`  : La clase es la encargada de realizar los test a la clase interactor.


## Principio de responsabilidad única:

El principio de responsabilidad única es el primero y más importante de los principios SOLID, en la que se describen los cinco principios para que una aplicación tenga mayor calidad, sea mantenible, reusable, escalable, modular, testeable. 
Este principio se basa en que un modulo o una función debe tener una sola responsabilidad, una sola razón para cambiar. Su propósito es que no se cuente con más de una responsabilidad para que el código no sea difícil de leer en el tiempo o por otras personas, también es importante para facilitar las pruebas unitarias.


## Código limpio (Según mi opinión):

Para mí un buen código o código limpio es aquel que se puede leer y entender fácilmente (que sus elementos sean ordenados) y más importante cumple de manera óptima con sus funciones.
