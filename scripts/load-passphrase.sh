passphrase=$(sops -d --extract '["passphrase"]' vault/tf.yaml)

export TF_VAR_passphrase="$passphrase"