Class {
	#name : #DatosPasajeroComponent,
	#superclass : #WAComponent,
	#instVars : [
		'usuario',
		'nombreUsuario',
		'contraseña',
		'dni',
		'fechaNac',
		'nombre',
		'apellido',
		'membresia',
		'mensaje',
		'tarjeta',
		'cambiarMembresia',
		'reanudarMembresia'
	],
	#category : #'IngSoftII-ui'
}

{ #category : #accessing }
DatosPasajeroComponent >> apellido [
	^apellido
]

{ #category : #accessing }
DatosPasajeroComponent >> apellido: unApellido [
apellido := unApellido 
]

{ #category : #accessing }
DatosPasajeroComponent >> cambiarMembresia [
	^cambiarMembresia
]

{ #category : #accessing }
DatosPasajeroComponent >> cambiarMembresia: unValor [
	cambiarMembresia:= unValor
]

{ #category : #accessing }
DatosPasajeroComponent >> cambiarMembresiaPasajero [
	self session user membresia nombre = 'gold'
		ifTrue: [ self session user setearCambiarMembresia.
			self session user cambiarMembresia
			"self session user membresia: MembresiaBasica new.
			self session user borrarTarjeta" ]
		ifFalse: [ self session user membresia: MembresiaGold new.
			(self
				call:
					(TarjetaComponent
						newWithUser: self session user
						andReturnGold: DatosPasajeroComponent))
				ifFalse: [ self session user membresia: MembresiaBasica new ] ]
]

{ #category : #accessing }
DatosPasajeroComponent >> contraseña [
^contraseña
]

{ #category : #accessing }
DatosPasajeroComponent >> contraseña: unaContraseña [
contraseña := unaContraseña
]

{ #category : #accessing }
DatosPasajeroComponent >> dni [
	^dni
]

{ #category : #accessing }
DatosPasajeroComponent >> dni: unDNI [
dni := unDNI
]

{ #category : #rendering }
DatosPasajeroComponent >> fechaNac [
	^fechaNac
]

{ #category : #rendering }
DatosPasajeroComponent >> fechaNac: unaFechaNac [
fechaNac := unaFechaNac 
]

{ #category : #rendering }
DatosPasajeroComponent >> initialize [
	super initialize.
	nombreUsuario := self session user nombreUsuario.
	contraseña := self session user contraseña.
	nombre := self session user nombre.
	apellido := self session user apellido.
	dni := self session user dni.
	fechaNac := self session user fechaNac.
	membresia := self session user membresia nombre.
	cambiarMembresia := false.
	self session user membresia = 'gold'
		ifTrue: [ tarjeta := self session user tarjeta ].
		reanudarMembresia :=false.
]

{ #category : #accessing }
DatosPasajeroComponent >> membresia [
	^membresia
]

{ #category : #accessing }
DatosPasajeroComponent >> membresia: unaMembresia [ 
	membresia := unaMembresia 
]

{ #category : #rendering }
DatosPasajeroComponent >> modificarDatosPasajero: aCanvas [
	"solo sale el mensaje de la contraseña corta"

	nombre ifEmpty: [ ^ self ].
	apellido ifEmpty: [ ^ self ].
	nombreUsuario ifEmpty: [ ^ self ].
	contraseña ifEmpty: [ ^ self ].
	fechaNac ifNil: [ ^ self ].
	fechaNac = Date today
		ifTrue: [ ^ self ].
	dni ifEmpty: [ ^ self ].
	nombreUsuario = self session user nombreUsuario
		ifFalse: [ (Sistema soleInstance
				modificarPasajero: self session user
				withNombreUsuario: nombreUsuario
				andNombre: nombre
				andApellido: apellido
				andContraseña: contraseña
				andFechaNacimiento: fechaNac
				andDNI: dni)
				ifNil: [ (Sistema soleInstance esValidaContraseña: contraseña)
						ifFalse: [ mensaje := 'Contraseña muy corta, mínimo 6 caracteres' ]
						ifTrue: [ (Sistema soleInstance existeUsuario: nombreUsuario)
								ifTrue: [ mensaje := 'El email ya se encuentra registrado en el sistema' ]
								ifFalse: [ (Sistema soleInstance esMayorDeEdad: fechaNac)
										ifFalse: [ mensaje := 'Debe ser mayor de edad para usar el sistema' ] ] ].
					^ self ] ]
		ifTrue: [ (Sistema soleInstance
				modificarPasajero: self session user
				withNombre: nombre
				andApellido: apellido
				andContraseña: contraseña
				andFechaNacimiento: fechaNac
				andDNI: dni)
				ifNil: [ (Sistema soleInstance esValidaContraseña: contraseña)
						ifFalse: [ mensaje := 'Contraseña muy corta, mínimo 6 caracteres' ]
						ifTrue: [ (Sistema soleInstance esMayorDeEdad: fechaNac)
								ifFalse: [ mensaje := 'Debe ser mayor de edad para usar el sistema' ] ].
					^ self ] ].
	cambiarMembresia
		ifTrue: [ self cambiarMembresiaPasajero ].
	reanudarMembresia
		ifTrue: [ self session user reanudarMembresia ].
	self answer
]

{ #category : #accessing }
DatosPasajeroComponent >> nombre [
	^nombre
]

{ #category : #accessing }
DatosPasajeroComponent >> nombre: unNombre [
 nombre := unNombre
]

{ #category : #accessing }
DatosPasajeroComponent >> nombreUsuario [
	^nombreUsuario
]

{ #category : #accessing }
DatosPasajeroComponent >> nombreUsuario: unNombreDeUsuario [ 
nombreUsuario := unNombreDeUsuario 
]

{ #category : #accessing }
DatosPasajeroComponent >> reanudarMembresia [
	^reanudarMembresia 
]

{ #category : #accessing }
DatosPasajeroComponent >> reanudarMembresia:unValue [
reanudarMembresia:=unValue
]

{ #category : #rendering }
DatosPasajeroComponent >> renderButtonsOn: aCanvas [
	aCanvas submitButton
		callback: [ self modificarDatosPasajero: aCanvas ];
		with: 'Modificar datos'.
	aCanvas submitButton
		callback: [ self answer ];
		with: 'Cancelar'
]

{ #category : #rendering }
DatosPasajeroComponent >> renderContentOn: aCanvas [
	aCanvas
		paragraph:
			(BasicComponent newWithParent: self andHome: HomeComponentPasajero new).
	aCanvas heading
		level: 4;
		with: mensaje.
	aCanvas
		form: [ self renderInputElementsOn: aCanvas.
			self renderButtonsOn: aCanvas .
	self session user membresia nombre = 'gold'
		ifTrue: [ self renderUsuarioGold: aCanvas ]]
]

{ #category : #rendering }
DatosPasajeroComponent >> renderInputElementsOn: aCanvas [
	| nuevaMembresia |
	self session user membresia nombre = 'gold'
		ifTrue: [ nuevaMembresia := 'basica' ]
		ifFalse: [ nuevaMembresia := 'gold ($250 al mes)' ].
	aCanvas label: 'Email'.
	aCanvas paragraph: [ aCanvas textInput on: #nombreUsuario of: self ].
	aCanvas label: 'Contraseña'.
	aCanvas paragraph: [ aCanvas passwordInput on: #contraseña of: self ].
	aCanvas paragraph: 'Nombre'.
	aCanvas paragraph: [ aCanvas textInput on: #nombre of: self ].
	aCanvas paragraph: 'Apellido'.
	aCanvas paragraph: [ aCanvas textInput on: #apellido of: self ].
	aCanvas paragraph: 'DNI'.
	aCanvas paragraph: [ aCanvas textInput on: #dni of: self ].
	aCanvas paragraph: 'Ingrese fecha de nacimiento día/mes/año'.
	aCanvas
		paragraph: [ (aCanvas dateInput options: #(day month year))
				on: #fechaNac
				of: self ].
	self session user cambioMembresia
		ifFalse: [ aCanvas checkbox on: #cambiarMembresia of: self.
			aCanvas text: ' Cambiar tu membresia a ' , nuevaMembresia ]
	
		ifTrue: [ aCanvas checkbox on: #reanudarMembresia  of: self.
			aCanvas text: ' Reanudar membresia gold ' .
			aCanvas break.
			aCanvas
				small:
					'Su membresia cambiará a básica a partir del: '
						, self session user fechaCambio printString ].
	aCanvas break.
	aCanvas break
]

{ #category : #rendering }
DatosPasajeroComponent >> renderUsuarioGold: aCanvas [
	aCanvas horizontalRule.
	aCanvas heading
		level: 3;
		with: 'Método de pago membresía gold'.
	aCanvas
		paragraph: [ aCanvas
				text:
					'Tarjeta de crédito terminada en: '
						, (self session user tarjeta numero last: 4) ].
	self session user cambioMembresia
		ifFalse: [ aCanvas submitButton
				callback: [ self
						call:
							(TarjetaComponent
								newWithUser: self session user
								andReturnGold: DatosPasajeroComponent) ];
				with: 'Cambiar metodo de pago' ] ifTrue:[aCanvas break.]
]
