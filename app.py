from flask import Flask, request, jsonify
from converter_service import ConversionService

app = Flask(__name__)
conversion_service = ConversionService()


@app.route('/api/convert', methods=['POST'])
def convert_document():
    data = request.get_json()
    filename = data.get('filename')
    output_format = data.get('format', 'pdf')

    result = conversion_service.convert(filename, output_format)
    return jsonify(result)


if __name__ == '__main__':
    app.run(debug=True)
