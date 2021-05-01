"
"" |application top1 top2 top3 usuario1 usuario2 usuario3 topicos1 topicos2 preg1 preg2 resp1 resp2 cuoora|

    CuOOra clearSoleInstance.
    application:= WAAdmin register: LoginComponent asApplicationAt:'cuoora'.
    application sessionClass: SessionWithUser.
	cuoora:=CuOOra soleInstance .
	top1:=cuoora agregarTopicoConNombre: 'OO1' conDescripcion:' '.
	top2:= cuoora agregarTopicoConNombre: 'Test de Unidad' conDescripcion: ' '.
	top3:=cuoora agregarTopicoConNombre: 'Smalltalk' conDescripcion: ' '.
	usuario1:= cuoora crearNuevoUsuarioConNombreDeUsuario: 'pedro@cuoora.com' conContrase√±a: 'pedro@cuoora.com'.
	usuario2:=cuoora crearNuevoUsuarioConNombreDeUsuario: 'diego@cuoora.com' conContrase√±a: 'diego@cuoora.com'.
	usuario3:= cuoora crearNuevoUsuarioConNombreDeUsuario: 'juan@cuoora.com' conContrase√±a: 'juan@cuoora.com'.

usuario3 agregarSeguido: usuario2.
usuario1 agregarSeguido:usuario3.

topicos1:=OrderedCollection new.
topicos1 add:top1;add:top2.
topicos2:=OrderedCollection new.
topicos2 add:top1;add:top3.

preg1:= usuario1 agregarPreguntaConTopicos: topicos1 conTitulo: '¬øPara qu√© sirve el m√©todo SetUp?' conDescripcion: ' '.
resp1 :=usuario2 agregarRespuestaDe: preg1 conTexto: 'Sirve para instanciar los objetos que son evaluados por el test en un √∫nico m√©todo y que se ejecute siempre antes de cada test'.

preg2:= usuario2 agregarPreguntaConTopicos: topicos2 conTitulo: '¬øQu√© significa #messageNotUnderstood?' conDescripcion: ' '.
resp2:=usuario1 agregarRespuestaDe: preg2 conTexto: 'Significa que el objeto que recibi√≥ el mensaje no encontr√≥ ning√∫n m√©todo para ejecutar en respuesta'. ""

Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #LoginComponent,
	#superclass : #AccessGrantingComponent,
	#category : #'IngSoftII-ui'
}

{ #category : #'private protocol' }
LoginComponent >> login [
	(self model userWithEmail: email protectedBy: password)
		ifNotNil: [ :it | self proceedWith: it ].
	email := nil.
	password := nil
]

{ #category : #'private protocol' }
LoginComponent >> registerNewUser [
	self call: RegisterComponent new
]

{ #category : #'private protocol' }
LoginComponent >> renderButtonsOn: aCanvas [
	self renderSignInButtonOn: aCanvas.
	aCanvas horizontalRule.
	aCanvas paragraph: 'Don''t have an account?'.
	self renderSignUpButtonOn: aCanvas.

]

{ #category : #'private protocol' }
LoginComponent >> renderSignInButtonOn: aCanvas [
	aCanvas submitButton
		callback: [ self login ];
		with: 'Sign In'
]

{ #category : #'private protocol' }
LoginComponent >> renderSignUpButtonOn: aCanvas [
	aCanvas submitButton
		callback: [ self registerNewUser ];
		with: 'Sign Up, it''s free'
]
