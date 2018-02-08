class Worker:
	"""docstring for Worker"""
	def __init__(self, name, pay):
		self.name = name
		self.pay = pay
	def lastName(self):
		return self.name.split()[-1]
	def giveRaise(self, percent):
		self.pay *= (1.0 + percent)
		

bob = Worker('Bob Smith', 40000)
print bob.lastName()
sue = Worker('Sue Jones', 6000)
print sue.lastName()