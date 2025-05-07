#!/usr/bin/env nu

source scripts/common.nu
source scripts/kubernetes.nu
source scripts/cnpg.nu
source scripts/kro.nu

def main [] {}

def "main setup" [] {

    rm --force .env

    let provider = (
        main get provider
            --providers [aws azure google upcloud kind]
    )

    main create kubernetes $provider

    main apply cnpg

    main apply kro

    kubectl create namespace a-team

    main print source
    
}

def "main destroy" [
    provider: string
] {

    main destroy kubernetes $provider

}
