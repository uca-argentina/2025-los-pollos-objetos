Class {
	#name : 'AccelerationCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
AccelerationCard >> effect [

	^ 1
]

{ #category : 'testing' }
AccelerationCard >> uses: aCardPlayHandler [

	aCardPlayHandler resolveAnAccelerationCardPlay: self
]
