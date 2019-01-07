#!/usr/bin/env bats

setup() {
    utils=$(cd $BATS_TEST_DIRNAME/..; pwd)/utils
    tmpdir=$(mktemp -d testXXXXXX)
    cat << EOF > $tmpdir/test1.json
{"utts": {"uttid1": [{"feat": "aaa.ark:123", "text": "あ い"}]}}
EOF

    cat << EOF > $tmpdir/test2.json
{"utts": {"uttid2": [{"feat": "aaa.ark:456", "text": "か き"}]}}
EOF

    cat << EOF > $tmpdir/valid
{
    "utts": {
        "uttid1": [
            {
                "feat": "aaa.ark:123", 
                "text": "あ い"
            }
        ], 
        "uttid2": [
            {
                "feat": "aaa.ark:456", 
                "text": "か き"
            }
        ]
    }
}
EOF

}

teardown() {
    rm -rf $tmpdir
}

@test "" {
    python $utils/concatjson.py $tmpdir/*.json > $tmpdir/out.json
    jsondiff $tmpdir/out.json $tmpdir/valid
}

