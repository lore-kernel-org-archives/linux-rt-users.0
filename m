Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A55B21A421;
	Thu,  5 Dec 2024 13:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733406965; cv=none; b=WQv0FhGNpbiZNj4lWVZtIuUMxSCzRFGjpxCevJiQwHOxi6s9Zmt2TOUu8sgE/S1vyL0ag819JCH1SCfFbzkTr/D23Ux4SiNn/a3zwZ+VR0Y9vYm1su/9kf6gYdQBbYqRf3D2sz5zuGKbq6BTgATJxGrtL0ebM68YLELtPVND5IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733406965; c=relaxed/simple;
	bh=6+U8Hn6pV/nUQdaGaiIYH4saSUcaW0ZGF6BKI2YpAzc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kSxKRgsYriwkL44ojb0waodYwcFKkBAUXZdkM3VxnLPYd0KLb+xSF39Ohtir5iiL11ngix7G+Ws/z04Z3SoUszUgjJ+Cft7mROLP1moqcDUHLqdgqu2jeqTZrdGgZnAFbsJHcc3GxiI+dgFErqALBgDZnHc1vU8jAXMTUZ+1K84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=WwcPi3OE; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="WwcPi3OE"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8CDEEDAE3A;
	Thu,  5 Dec 2024 14:46:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1733406364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=O/V1XIEhusXLYo92tGRw31NorL4hW+RIN3KHibHu/Cg=;
	b=WwcPi3OEYqMm3OKz922FwlCeL7w0CAjhdNnsYciDGDHKdNv2ue1jMbipdkWHXPdlbwih7P
	tPHP90TVxUYWDG5vafYvsGXrMA0CPeiYATQU3TZ5Em0vrZoOdHjFzv3o5rJvPjfnmJ20va
	fI8tGn5Rx3K8Ldmz2QI8WiP3HnVtvw+ciQw082nOgx4syslDVLGfkmsRfQvbS//3xCmuL+
	F4MrL9NYjOTQ3l9byi4yeXhbY1ibaJlVHW817sq2nVbwwerKR+NwaFxf3361AdwQNQV3Ev
	Ya0PtsBkXqPsz3BqFBA5fQjm5CdHpgn7SYK53uKxcaI6U3jrG8mLEba6csC6CQ==
Date: Thu, 5 Dec 2024 14:46:00 +0100
From: Daniel Wagner <wagi@monom.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org, 
	stable-rt@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Tom Zanussi <tom.zanussi@linux.intel.com>, Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.19.324-rt139
Message-ID: <173340631641.6447.16784929560176199881@beryllium.lan>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3

Hello RT-list!

I'm pleased to announce the 4.19.324-rt139 stable release. Just a stable
update, no RT specific changes.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: b33e0cf394c4dfb11c91395dd25ccfc2a9fd2789

Or to build 4.19.324-rt139 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.324.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patch-4.19.324-rt139.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v4.19.322-rt138:
---

Daniel Wagner (1):
      Linux 4.19.324-rt139
---
localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---
diff --git a/localversion-rt b/localversion-rt
index 9f63718d5731..e0b93414dc30 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt138
+-rt139
