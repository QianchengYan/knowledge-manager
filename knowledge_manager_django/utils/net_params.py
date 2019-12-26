class NetParams:
    def __init__(self, data, success, message):
        self.data = data
        self.success = success
        self.message = message

    def get_params(self):
        return {
            'data': self.data,
            'success': self.success,
            'message': self.message
        }
