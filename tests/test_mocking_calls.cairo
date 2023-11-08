use myapp::{ IMyContractDispatcher, IMyContractDispatcherTrait };
use snforge_std::{ declare, start_mock_call, stop_mock_call };
use snforge_std::cheatcodes::contract_class::ContractClassTrait;
use starknet::ContractAddress;

#[test]
fn mock_call_with_dispatcher() {
    let call_address: ContractAddress = 8.try_into().unwrap();
    let contract_address = deploy_contract(call_address);
    let dispatcher = IMyContractDispatcher { contract_address };

    start_mock_call(call_address, 'some_function', 15);
    let result = dispatcher.call_using_dispatcher();
    stop_mock_call(call_address, 'some_function');
    
    assert(result == 15, 'Wrong result');
}

#[test]
fn mock_call_with_syscall() {
    let call_address: ContractAddress = 8.try_into().unwrap();
    let contract_address = deploy_contract(call_address);
    let dispatcher = IMyContractDispatcher { contract_address };

    start_mock_call(call_address, 'some_function', 15);
    let result = dispatcher.call_using_syscall();
    stop_mock_call(call_address, 'some_function');
    
    assert(result == 15, 'Wrong result');
}

fn deploy_contract(call_address: ContractAddress) -> ContractAddress {
    let contract = declare('MyContract');
    let constructor_args = array![call_address.into()];
    contract.deploy(@constructor_args).unwrap()
}