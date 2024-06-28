Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D8378C76
	for <linux-rt-users@vger.kernel.org>; Fri, 28 Jun 2024 20:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719605311; cv=none; b=h2kcRhyFEpqv8wEmUrVRya+Xm5MN1kc0/Ro8ovm6ofJYYAWq9PESW9xfz/VBirk+JEokUmOy+WKNqjW5XK93lzVWfStaKNGFb9iu1fKjMdTGefZJ6rsBe5QY6aZfWM7ZkAsOzgNfHqor7zSxxeQR0GP9qWT5JIVQCOn4y5IjEVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719605311; c=relaxed/simple;
	bh=Iv3PBbELD9qXOvx0Ek96gu+fwHbcWl4UqQzHXdu+zl4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rnEnRbZWnAHMNuKyINGn9QTvsmwuBAOPyvsWFy9B/Dhz/0r+7tVYb49XICBXuUNfut4BWrciKEmo+2fams8JH2o6rxVQQh+QJdTxonncB1LJxSQ74Cna+1Ivlbw54qmt0+78DwcO4hO1Zfg0aBxSo+cMsRHHALRrgnSU0iJ+9uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dtUxORNV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dtUxORNV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719605307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=UopZ8FolvOMRwevPAZYK/V387VzJ0kOpvzwqKf4M0tg=;
	b=dtUxORNVZ32g4ijFXZOT6ThNyyL0pN1BHmrSDuSY3dRa2ctpwtAjJmteqQ3pgwVM4yDg99
	HySJPPzrqlQaPEjvui5tG92t5fiXzH8zABWXL+niUe4d4aO9+4UNAO16Kj1tGqpKDfQW1c
	xii7O8sEJRHD93tKC7kgBPWMafzSqG4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-_KEJYiAOMHGv0VeZaa-70g-1; Fri,
 28 Jun 2024 16:08:23 -0400
X-MC-Unique: _KEJYiAOMHGv0VeZaa-70g-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C4E9B19560B3;
	Fri, 28 Jun 2024 20:08:19 +0000 (UTC)
Received: from localhost (unknown [10.22.9.246])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8487E19560A3;
	Fri, 28 Jun 2024 20:08:18 +0000 (UTC)
Date: Fri, 28 Jun 2024 17:08:17 -0300
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
	Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 5.10.219-rt111
Message-ID: <Zn8YMRzzOv-jwvSd@uudg.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hello RT-list!

I'm pleased to announce the 5.10.219-rt111 stable release.

This release is just an update to the new stable 5.10.219 version and
no RT changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 4a4ea2ea1cc624964d53cf22fa5f92a9f43708bb

Or to build 5.10.219-rt111 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.219.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.219-rt111.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

