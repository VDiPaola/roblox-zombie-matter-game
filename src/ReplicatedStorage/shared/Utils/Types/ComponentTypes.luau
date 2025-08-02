--!strict

export type ComponentType<T> = {
	patch: (self: T, partialDataObject: T) -> ComponentType<T>,
	new: (self: T) -> ComponentType<T>,
} & ((object: T) -> ComponentType<T>) & T

export type StateType = {
	current: string?,
	time: number?,
	transitionTable: { [string]: boolean }?,
}

export type StateChangeRequestType = {
	target: string,
}

export type AnimationPlayerType = {
	animationTable: { [string]: KeyframeSequence },
}

export type ModelType = {
	model: Model,
}

export type HitFrameType = {
	attackerId: string,
}

return nil
