Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B3823D2B4
	for <linux-rt-users@vger.kernel.org>; Fri, 17 Oct 2025 02:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760667903; cv=none; b=u+mWGKT4QlpLpmHH6ZJCicZKZEtNdNZOl2zCHU1qHtFBrIFs0Ul1WmoU1VFWY/+GfEK7sfk/yOH6HPK+NFeUNPs9DwxVhjbM/l/pbOW9ouH/eqCt7Yi2XDaN2UVstjpOxbqiZMtLv/FISLDtbKM1W+8POBiZ1D0UsAb3NOn4aRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760667903; c=relaxed/simple;
	bh=Ymv0GH86gyuxfT8LyNZe/v1f/BNqCCzT2dm/NdWH6ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=fax1jTCYhu7JgQJZEBb+wlGt3pLSyuUtC0bGEsiJB4fE8oJOh2FWhL/dkLEwxwkDZLJeaaWcA1Pc6PbG5vlRLgdSsr0LGcpuyagyaLnKPf9IxwqobEe/6LpyeKEA4t3lLoKixmtQyLmxsG881lI+NIfcZWvlV9yTAaxva8GUAbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjGdJw/i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjGdJw/i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63961C4CEFB;
	Fri, 17 Oct 2025 02:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760667902;
	bh=Ymv0GH86gyuxfT8LyNZe/v1f/BNqCCzT2dm/NdWH6ck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FjGdJw/ioFBUeSuknBcdIGGbjniJYiYEnKvloaEYZyGMtDZ22M7Z4wJ1mpfGvMZM0
	 ZZkc4irSEg9yTSfBXV+Q5l3MGnrmxfsPb714j5eppE8O/i6gR9vkBG/LX6kOHvXr21
	 sETNcK/zjI2DMe3NzVNv2A39sf3ubISwQUyHABVbD5yH2LKXq2EVsWE8WqGgm3TE+O
	 yp4JicfdU4Yw8B60WNDGR4Oc8Kq/v56MMqIIBFlB1I5fF1HR9QzMMM0JWKPsLD9SL+
	 OcObtWDZXKGS5ESh28lZo/pa/+zT3zEXnNkfwOhFTbd1fAZA/KEx1DRWTKmcBC454I
	 QW4E1LNsuROQA==
From: Clark Williams <clrkwllms@kernel.org>
To: linux-rt-users@vger.kernel.org
Cc: Derek Barbosa <debarbos@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Clark Williams <williams@redhat.com>,
	wander@redhat.com,
	marco.chiappero@suse.com,
	chris.friesen@windriver.com,
	luochunsheng@ustc.edu
Subject: [PATCH 11/12] scripts: fix run-local if bashism
Date: Thu, 16 Oct 2025 21:24:43 -0500
Message-ID: <20251017022444.118802-11-clrkwllms@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017022444.118802-1-clrkwllms@kernel.org>
References: <20251017022444.118802-1-clrkwllms@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit

From: Derek Barbosa <debarbos@redhat.com>

In older versions of Bash, mainly 4.2.X, a semicolon (or newline) is
requied after a conditional statement and before the `then` keyword.

Add the semicolon to allow testing and quick "local runs" on legacy
kernels.

Signed-off-by: Derek Barbosa <debarbos@redhat.com>
Signed-off-by: Clark Williams <clrkwllms@kernel.org>
Signed-off-by: Clark Williams <williams@redhat.com>
---
 scripts/run-local.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/run-local.sh b/scripts/run-local.sh
index 0ce147634472..e65f34dd46a4 100755
--- a/scripts/run-local.sh
+++ b/scripts/run-local.sh
@@ -44,7 +44,7 @@ parse_args()
 # script start
 #
 
-if [[ ! -x ./stalld ]] then
+if [[ ! -x ./stalld ]]; then
    echo "No stalld executable in the current directory!"
    exit 1
 fi
-- 
2.51.0

