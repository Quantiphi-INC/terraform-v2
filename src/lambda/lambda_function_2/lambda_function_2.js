exports.handler = async (event) => {
    const response = {
        statusCode: 200,
        body: JSON.stringify('Hello from lambda_function_2_v4'),
    }
    return response 
}