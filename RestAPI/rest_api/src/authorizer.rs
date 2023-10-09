async fn construct_authority() -> Result<Authority> {
    let validator = CoreValidator::default()
        .add_approved_algorithm(Algorithm::RS256)
        .add_allowed_audience(Audience::from_static(AUDIENCE));

    let authority = Authority::new_from_url(
        "https://dev-vtgjrzbo50ktq0do.us.auth0.com".into(),
        validator,
    )
    .await?;

    authority.spawn_refresh(std::time::Duration::from_secs(600));

    Ok(authority)
}
