Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74142E5B02
	for <linux-rt-users@vger.kernel.org>; Fri,  4 Jul 2025 16:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751646548; cv=none; b=IftFwRB6xoQc34uqJlCzfFX+BcEe5OYgLlLilScU1A3bIzc3IKfCgKzu+g566jfwf8D7d8lnsBtumXTH6wvkkQuri0xD4POndpPEVy3MKmEEUbq/pgtOOKNAfIQ/c3iIQARzrXHTx72CNdf/xg+nx5f/ual1FM06EZwPUGjqjQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751646548; c=relaxed/simple;
	bh=QM79iFRulVD2NTqeRKm/ddIOujz+6Fm1zZP+WS32gc8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cjnbZObmbM4kiPT+5dkcdimRjtMB43mouSL5b329mUz5sTZ51VH5MiIfbxBDoYGrK5PiqaOhxCndrW/yzQdWfTr+fZBPKZ+EVSeAVivVx6KDYafgNFNLTwiu+GUzNlP/UtI9TXvn7zO95cX1szbyosDHZrrS8unNwLvr8jrib0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bWOSeh5w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bWOSeh5w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751646546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=UBAARmmHHHQnJjuWd2hsf0lUGlOqof9veeGwsUcvpkE=;
	b=bWOSeh5wFUY5liKcw8boq139u1E7WtRj2x77dF4MtSaKhDr1CChln6v+ysjGNfmuTnyS5Y
	CGJ5SquuMfs3aaVZ2RhBim+PJUr0FgK8sictEIMUBd5TdGQLzLQVm2vetJWkVg8iCp/o/f
	NyXXBrSgFthRIhXFydumxv1urtRVeI0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-33-11Mj4CkFOTqh7zedNGjAhw-1; Fri,
 04 Jul 2025 12:29:02 -0400
X-MC-Unique: 11Mj4CkFOTqh7zedNGjAhw-1
X-Mimecast-MFC-AGG-ID: 11Mj4CkFOTqh7zedNGjAhw_1751646541
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFA9F180029F;
	Fri,  4 Jul 2025 16:29:00 +0000 (UTC)
Received: from localhost (unknown [10.22.64.73])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7C23F195608F;
	Fri,  4 Jul 2025 16:28:59 +0000 (UTC)
Date: Fri, 4 Jul 2025 13:28:57 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	stable-rt <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Clark Williams <williams@redhat.com>,
	Mark Gross <markgross@kernel.org>, Pavel Machek <pavel@denx.de>,
	Jeff Brady <jeffreyjbrady@gmail.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 5.10.239-rt133
Message-ID: <aGgBSTszSg4lEaH8@uudg.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hello RT-list!

I'm pleased to announce the 5.10.239-rt133 stable release.

This release is an update to the new stable 5.10.239 version and
no RT-specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: ed0da570e3518a29517868bbf86b4932eb7744e6

Or to build 5.10.239-rt133 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.239.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.239-rt133.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

