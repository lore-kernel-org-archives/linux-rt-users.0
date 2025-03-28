Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A911531C5
	for <linux-rt-users@vger.kernel.org>; Fri, 28 Mar 2025 20:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743193762; cv=none; b=sjflPRbSfLAx/x9mdFTs/bIY6sYCKvuq1IbwpBvnlhHDfInKxIM/cT6g/PDJAIScbslunoaHkMC3fGci0aQM4DG+cSw3ctgoemRRZjdrJy2IYAnysGl3juNYiYfEhMi2Bn7jDd3oZJW+5LOr3Hctbb0jQJsS9GoXX+uCallzuLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743193762; c=relaxed/simple;
	bh=fWXgaxKeptKvwUIRzd4uyR2T+P3ORdiTS01RI347L/c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q3PI2KBHKcylA/lMT4WCVNceFDju+FmMzLpTxabp2tndEUwNPJQd5ROrArclCd/GKVdi0K5DjDByPxMtEhGqBYfAxd4SMFLp375TSdolTdJXI7M1MPZ/mZNExwg7k6dxg97h1yiV+Ly8rpuxYzPsLTzrVYzZlqNpPpsZH2t+gRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1tyGKN-0006bX-0T;
	Fri, 28 Mar 2025 20:29:18 +0000
Received: from ben by deadeye with local (Exim 4.98.1)
	(envelope-from <ben@decadent.org.uk>)
	id 1tyGKK-000000006jp-2V2W;
	Fri, 28 Mar 2025 21:29:16 +0100
Date: Fri, 28 Mar 2025 21:29:16 +0100
From: Ben Hutchings <benh@debian.org>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: linux-rt-users@vger.kernel.org
Subject: [PATCH 5.10] rt: Fix buid issue in be2net
Message-ID: <Z-cGnAlIvThsPiH8@decadent.org.uk>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="df1rYqAy360g/76A"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--df1rYqAy360g/76A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The problem described here is specific to v5.10-rt.

The function be_cmd_unlock() includes the line:

    return spin_unlock_bh(...);

In 5.10-rt, with CONFIG_PREEMPT_RT enabled, spin_unlock_bh() is a
macro that doesn't expand to a valid expression, so this fails to
compile.

A similar issue was recently fixed in at_hdmac.  Do the same thing
here: make the spin_unlock_bh() and return 2 separate statements.

Signed-off-by: Ben Hutchings <benh@debian.org>
---
 drivers/net/ethernet/emulex/benet/be_cmds.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/emulex/benet/be_cmds.c b/drivers/net/ethe=
rnet/emulex/benet/be_cmds.c
index 9812a9a5d033..b3540b3d2862 100644
--- a/drivers/net/ethernet/emulex/benet/be_cmds.c
+++ b/drivers/net/ethernet/emulex/benet/be_cmds.c
@@ -875,10 +875,12 @@ static int be_cmd_lock(struct be_adapter *adapter)
 /* Must be used only in process context */
 static void be_cmd_unlock(struct be_adapter *adapter)
 {
-	if (use_mcc(adapter))
-		return spin_unlock_bh(&adapter->mcc_lock);
-	else
+	if (use_mcc(adapter)) {
+		spin_unlock_bh(&adapter->mcc_lock);
+		return;
+	} else {
 		return mutex_unlock(&adapter->mbox_lock);
+	}
 }
=20
 static struct be_mcc_wrb *be_cmd_copy(struct be_adapter *adapter,

--df1rYqAy360g/76A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmfnBpgACgkQ57/I7JWG
EQk0bBAAskUgVKQFzYWmTsb48OpHjBGEsFlOC3c4qXtrlwQgT5FkjT5QNDPe3/tX
mRKqkUZDyG575ImzN+M4FBmyJZjrlwUwNpjRTKm7YZaR4A5QyyiIt3cbzVlIfNKT
KYaM37d5oTzfNCU7GH3JUhsETBdt/hviu9JUQnhGGG2R1DmCQKLylao86vSzVLXi
11qMWFbYktwBai2sVpbiZPw7chWlC5jMxdsb7alWCm7qT4bRawbrudnWWSdMNlcf
SpXSaVYZhLnuB9+9wx/yeVRrabOb+pNekKuarGckUaDiX+k3KEOrsG8e57T6ghK6
sV6DHMS0zKKk4lqjAmKGYhiqcOFaZDjH37jOXryYuI0iexYJu+gvxRP1Z8fXbsux
x4GqTR0fjwm4r7uLAgVg1s7ib1ycXtKnA/1yniHkm+upO1VwsKH2cu4dNvBpx8Z2
vTySW1Q7iOd5a2yBPFCjs2hnJtHWnOVVXsyCADydBOdS5hFCDFBh0w5NGKIRthBT
U8kDAshIgW0u12vEsaqVBaCN3nL+cqVzWoRum/g9lXATxKXbe9kRsXeHXqKE3iZn
8cFs2JBoLvfC7cWzUd0+0kIrBUJTBBrm+aoAHa4p+OoTOC9Nd1YZDFEDTMnFLjnZ
Qd4g84KCV2yy5iHuoMe/tKWWxwYAxFZc+bKmr3cfyCxzVyESLlY=
=IoGZ
-----END PGP SIGNATURE-----

--df1rYqAy360g/76A--
