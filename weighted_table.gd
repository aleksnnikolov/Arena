class_name WeightedTable

var items: Array[Dictionary] = []
var weight_sum: int = 0


func add_item(item, weight: int):
	items.append({"item": item, "weight": weight})
	weight_sum += weight


func pick_item(exclude: Array = []):
	var adjusted_items: Array[Dictionary] = exclude_items_from_table(exclude);
	var adjusted_weight_sum = calculate_weight_sum(adjusted_items)
	
	var chosen_weight = randi_range(1, adjusted_weight_sum)
	var iteration_sum = 0
	for item in adjusted_items:
		iteration_sum += item["weight"]
		if chosen_weight <= iteration_sum:
			return item["item"]


func remove_item(item_to_remove):
	items = items.filter(func(item): return item["item"] != item_to_remove)
	weight_sum = calculate_weight_sum(items)


func calculate_weight_sum(table):
	var calcultated_weight_sum = 0
	for item in table:
		calcultated_weight_sum += item["weight"]
		
	return calcultated_weight_sum

func exclude_items_from_table(exclude: Array):
	var adjusted_items: Array[Dictionary] = items
	if exclude.size() > 0:
		adjusted_items = []
		for item in items:
			if item["item"] in exclude:
				continue
			else:
				adjusted_items.append(item)
				
	return adjusted_items
