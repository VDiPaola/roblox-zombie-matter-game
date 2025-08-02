local MatterUtil = {}

function MatterUtil.getAll(world, id, ...)
	for _, component in ipairs({ ... }) do
		if not world:get(id, component) then
			return false
		end
	end
	return true
end

return MatterUtil
