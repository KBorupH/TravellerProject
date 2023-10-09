use aliri::jwt;
use aliri_clock::UnixTime;
use aliri_oauth2::HasScope;
use aliri_oauth2::Scope;
use serde::Deserialize;

#[derive(Debug, Deserialize)]
pub struct CustomClaims {
    iss: jwt::Issuer,
    aud: jwt::Audiences,
    sub: jwt::Subject,
    scope: Scope,
}

impl jwt::CoreClaims for CustomClaims {
    fn nbf(&self) -> Option<UnixTime> {
        None
    }
    fn exp(&self) -> Option<UnixTime> {
        None
    }
    fn aud(&self) -> &jwt::Audiences {
        &self.aud
    }
    fn iss(&self) -> Option<&jwt::IssuerRef> {
        Some(&self.iss)
    }
    fn sub(&self) -> Option<&jwt::SubjectRef> {
        Some(&self.sub)
    }
}

impl HasScope for CustomClaims {
    fn scope(&self) -> &Scope {
        &self.scope
    }
}

aliri_axum::scope_guards! {
    type Claims = CustomClaims;

    pub scope AdminOnly = "admin";
    pub scope ReadWrite = "read write";
    pub scope Read = "read";
}
