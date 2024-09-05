def get_std(self,data):
    avg = self.get_avg(data)
    diff_list = [ (avg - x ) ** 2  for x in data ]
    var = sum(diff_list) / len(data) 
    return var ** 0.5  