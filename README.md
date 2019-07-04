# ContainerView SlideButton

[Project created with Xcode V10.2.1]
[Deployment Target > 11.0 ]

## Project Base.
Creación de un Botón Deslizante con esquinas redondeadas para mostrar Views:
Un UIView se comportará como el botón deslizante; éste está dentro de otro UIView, que será el área donde se podrá desplazar.
De acuerdo a la posición en la que se encuentre el botón, se mostrará el childView correspondiente dentro del ContainerView.
El botón tiene dos animaciones para mover el botón a la derecha o izquierda, según sea el caso:
#### [moveButtonLeft]: 
-Si el botón está a la izquierda entonces: Si el botón no llega a sobrepasar el 50% del área de desplazamiento, se regresa a su posición origen.
-Si el botón está a la derecha entonces: Si la posición del botón es mayor a su tamaño, entonces el botón se desplaza a la izquierda.
#### [moveButtonRigth]:
-Si el botón está a la izquierda entonces: Si el botón sobrepasa el 50% del área de desplazamiento, el botón se desplaza a su derecha.
-Si el botón está a la derecha entonces: Si la posición del botón es menor a su tamaño, se regresa a su posición origen.

## Style
Al contenedor de las vistas se le da estilo de esquinas redondeadas en la parte superior.

## ViewController incomplete
_Bug: Al mostrar el ChildViewController en diferentes dispositivos, se ve incompleta la vista. { Corregido }