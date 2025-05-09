use lambda_runtime::tracing::log;
use lambda_runtime::{service_fn, Error, LambdaEvent};
use serde::Deserialize;
use serde_json::{json, Value};

#[derive(Deserialize, Debug)]
struct EnyxEvent {
    something: String,
    something_else: String,
}

async fn handler(event: LambdaEvent<Value>) -> Result<Value, Error> {
    let evnt: EnyxEvent = serde_json::from_value(event.payload)?;
    log::info!("{:?}", evnt);
    Ok(
        json!({ "message": format!("something: {} -- something_else: {}", evnt.something, evnt.something_else) }),
    )
}

#[tokio::main]
async fn main() -> Result<(), Error> {
    lambda_runtime::run(service_fn(handler)).await
}
