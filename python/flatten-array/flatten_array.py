def flatten(iterable):
    if len(iterable) == 0:
        return []
    rest = flatten(iterable[1:])
    if iterable[0] != None:
        if isinstance(iterable[0], list):
            return flatten(iterable[0]) + rest
        if iterable[0] != None:
            return [iterable[0]] + rest
    return rest
