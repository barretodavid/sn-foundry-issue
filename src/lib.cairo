#[starknet::interface]
trait IMyContract<T> {
    fn call_using_dispatcher(self: @T) -> felt252;
    fn call_using_syscall(self: @T) -> felt252;
}

#[starknet::interface]
trait IOtherContract<T> {
    fn some_function(self: @T) -> felt252;
}

#[starknet::contract]
mod MyContract {
    use super::{ IMyContract, IOtherContractDispatcher, IOtherContractDispatcherTrait };
    use starknet::{ ContractAddress, call_contract_syscall };

    #[storage]
    struct Storage {
        call_address: ContractAddress
    }

    #[constructor]
    fn constructor(ref self: ContractState, call_address: ContractAddress) {
        self.call_address.write(call_address);
    }

    #[external(v0)]
    impl MyContractImpl of IMyContract<ContractState> {
        fn call_using_dispatcher(self: @ContractState) -> felt252 {
            let call_address = self.call_address.read();
            let dispatcher = IOtherContractDispatcher {
                contract_address: call_address
            };
            dispatcher.some_function()
        }

        fn call_using_syscall(self: @ContractState) -> felt252 {
            let call_address = self.call_address.read();
            let result = call_contract_syscall(call_address, 'some_function', array![].span()).unwrap();
            *result.at(0)
        }
    }
}