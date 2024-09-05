class Scaler:
    def get_avg(self,data):
        avg = sum(data) / len(data)
        return avg

    def get_std(self,data):
        avg = self.get_avg(data)
        diff_list = [ (avg - x ) ** 2  for x in data ]
        var = sum(diff_list) / len(data) 
        return var ** 0.5  

    def fit_transform(self,data):
        pass
    def transform(self,data):
        pass

class StandardScaler(Scaler):

    def fit_transform(self, data):
        self.avg = self.get_avg(data)
        self.std = self.get_std(data)
        self.result = []
        for x in data:
            self.result.append((x-self.avg)/self.std)

        return self.result
    
    def transform(self, data):
        return self.fit_transform(data)
    
class MinMaxScaler:
    def fit(self, data): 
        self.min_ = min(data)
        self.size_ = max(data) - self.min_
    def fit_transform(self,data):
        self.fit(data)
        return self.transform(data)
    def transform(self,data):
        return [ (x-self.min_) / self.size_ for x in data]
    def inverse_transform(self,data):
        return [ x * self.size_ + self.min_ for x in data]