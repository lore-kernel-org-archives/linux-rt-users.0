Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D60B673
	for <linux-rt-users@vger.kernel.org>; Mon, 31 Mar 2025 19:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743450503; cv=none; b=B0sBJNar/l+JeMhyXu57grN4bKSKETOTN5v/8fozpV5B0ytXqH9dWL3KISut7/C/zPgSC7QFiqzeeOh958jp4GRBq/1NdqbhcyaURMKqK1//11rbPAq/0123yXK8vatjPmXiW3Wrs9y5UopIYkcVeX/Ju7kVlGYRO0Njf1NcyWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743450503; c=relaxed/simple;
	bh=jx+kOVHSUKCbsRcFvKLazaf4NS5jfInnRrJa8Rwz4xE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pItzQ6TVmyIZRqhfHzwA8A2Ix33jliKfTJTNJttL453rdYUGNsj+0uQPbpfdI6u4ij47AhdBht3PFyKJgcszgNQ1pkOlJizXsE/uKHyJJ1VBSIZkJf1FX0OgaJ1lNNlYrtcTbwoaCwjUgsnrdcqUGMfO8giIDKBLuY9VgV8JIHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AShaYhQd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AShaYhQd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743450501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=CZUl/W/3DHj1eibZ+TU4Ipkjrazfz2B71T5aEi4wVx4=;
	b=AShaYhQdVOqoZ5SELAP6kumRN3ukHZqmGmTPkbQ/0ARhxw0xLtulbGwkcAb8h759LTu3e+
	MsN122zCquUwl/pT9hHRcYSA3uJ4bZ9fDU+5aix7UsBtw3fsWehRAKhTIG+P97MjF93Dw4
	NKyCIU9NTEb9BYFQpEQmtK4SdlTMMsw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-qMpU8gAMOwOyyBQThh2qMg-1; Mon,
 31 Mar 2025 15:48:16 -0400
X-MC-Unique: qMpU8gAMOwOyyBQThh2qMg-1
X-Mimecast-MFC-AGG-ID: qMpU8gAMOwOyyBQThh2qMg_1743450494
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E7351800349;
	Mon, 31 Mar 2025 19:48:14 +0000 (UTC)
Received: from localhost (unknown [10.22.65.234])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F3E33180B488;
	Mon, 31 Mar 2025 19:48:12 +0000 (UTC)
Date: Mon, 31 Mar 2025 16:48:11 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	stable-rt <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	Mark Gross <markgross@kernel.org>, Pavel Machek <pavel@denx.de>,
	Jeff Brady <jeffreyjbrady@gmail.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Ben Hutchings <benh@debian.org>
Subject: [ANNOUNCE] 5.10.235-rt129
Message-ID: <Z-rxe2n4qOskrg2f@uudg.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hello RT-list!

I'm pleased to announce the 5.10.235-rt129 stable release.

While working on the stable update 5.10.235-rt128, a build problem
on the be2net driver was discovered on RT. That inconvenience was
fixed, hence the release of 5.10.235-rt129.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: d7dcda5ab69cd154e135797b8d116d5a0736eae2

Or to build 5.10.235-rt129 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.235.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.235-rt129.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

Changes from v5.10.235-rt128:
---

Luis Claudio R. Goncalves (2):
      rt: fix build issue in be2net
      Linux 5.10.235-rt129
---
drivers/net/ethernet/emulex/benet/be_cmds.c | 7 ++++---
 localversion-rt                             | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)
---
diff --git a/drivers/net/ethernet/emulex/benet/be_cmds.c b/drivers/net/ethernet/emulex/benet/be_cmds.c
index 9812a9a5d033..3068ccd37034 100644
--- a/drivers/net/ethernet/emulex/benet/be_cmds.c
+++ b/drivers/net/ethernet/emulex/benet/be_cmds.c
@@ -875,9 +875,10 @@ static int be_cmd_lock(struct be_adapter *adapter)
 /* Must be used only in process context */
 static void be_cmd_unlock(struct be_adapter *adapter)
 {
-	if (use_mcc(adapter))
-		return spin_unlock_bh(&adapter->mcc_lock);
-	else
+	if (use_mcc(adapter)) {
+		spin_unlock_bh(&adapter->mcc_lock);
+		return;
+	} else
 		return mutex_unlock(&adapter->mbox_lock);
 }
 
diff --git a/localversion-rt b/localversion-rt
index 6d2a676e2033..90303f5aabcf 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt128
+-rt129

