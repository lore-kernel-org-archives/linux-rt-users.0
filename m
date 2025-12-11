Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5DF2701CB
	for <linux-rt-users@vger.kernel.org>; Thu, 11 Dec 2025 21:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765487770; cv=none; b=PwjgKmFzcD+e6c/8Vne7jozlBBen5xqRlNiISc1jfj2IP0/4Kx2G7U7NZ2b40VhTodWQwCa2+WPZ/pSdnsH8tE1b1I0M2HxdOdDahJ1m5NOZB2Z90KUP7D0kemDNe56DRqUBOh2BZWyKVdjkNV0E+JLFYM+0zTS6FqFJ41NJr+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765487770; c=relaxed/simple;
	bh=wATbbmIYJgbH0UmsyaBfV3NU2vstVZWkqaMUAsmCz40=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DTtCkquSQU8gevswAd/7sndTwl6vtlHosChSyoaoNT37uuvKZKaEa/YrjKvfvCfzhDb0Ev48M0VqTH9sKRI8h3holJKjkO5SLKSB6o51SAtAChncAjRoINy7zBtZMCq9iQ+MdL8AwzGZREbthK3BgBFGqT+0jVQ8bL8y5l19Brk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZMcOEKJS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZMcOEKJS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765487767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=nqrqISFYVkuxT/QgtTRWqRLSMsk0Ltq6MQQWKADLbcY=;
	b=ZMcOEKJSd7MQxCEkyy5NG8WOH6rK8fsFPV7eyCwnwMh68h6mOdCq8tX+CnQEZ90nicRl9l
	x1rgSWkwGjr4ri4NUdN0764IINulMzaQ0wXCZooSYkyUrQpQ9KSIJ4w6Piyz/bD4wnKYSp
	epE+Zosnb+oEI1scU1PvYSLsRAQaAn4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-510-Waq-xNNKNQqbHVQGSR5RNg-1; Thu,
 11 Dec 2025 16:16:02 -0500
X-MC-Unique: Waq-xNNKNQqbHVQGSR5RNg-1
X-Mimecast-MFC-AGG-ID: Waq-xNNKNQqbHVQGSR5RNg_1765487760
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2552119560B2;
	Thu, 11 Dec 2025 21:16:00 +0000 (UTC)
Received: from localhost (unknown [10.22.80.58])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ED11330001A2;
	Thu, 11 Dec 2025 21:15:58 +0000 (UTC)
Date: Thu, 11 Dec 2025 18:15:57 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	stable-rt <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Clark Williams <williams@redhat.com>, Pavel Machek <pavel@denx.de>,
	Jeff Brady <jeffreyjbrady@gmail.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 5.10.247-rt141
Message-ID: <aTs0jVBTwOxAlm8t@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hello RT-list!

I'm pleased to announce the 5.10.247-rt141 stable release.

This release is just an update to the new stable 5.10.247 version and
no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 50175885f5585879d8e3ee001599cde54779ac8b

Or to build 5.10.247-rt141 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.247.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.247-rt141.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

