Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E6F30DD31
	for <linux-rt-users@vger.kernel.org>; Tue, 16 Sep 2025 15:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758035661; cv=none; b=X1LKASzkoWQpW98+q45kZeQ8wJ2OqSKqkLOJCt8KqXAtm14yKOR7xPV2eIZBoMt6JUtP4NmgtIp+62u0TQGlm80yxCCrHJU6Kr0U86Floxt5cKIZcbjFcOZH2Rb9pNLE1EtjpXxJtHSJsq+sGBS2zlTXNzICkgzn459Oc3a2Yjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758035661; c=relaxed/simple;
	bh=TF6yDTkTIFtB1LLtZfYKERR2ZcwJswQ2soyQcfqzZhs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PKaY1U1fmD2oFrLSINphs2Qhmch9QMfvlk0+dAbAKndcO+dI1b+nvKgupg+uAtjsVIKMkTXkv80pGZ7B01EU7ehNL4/MsyjJsg+Km9NvNWTFrLWpa2tE5Swm4DZpJLgJrgvXacFoN1xnYXidElDx9FZA6SfUzWnve11RtVrSJ4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QAbuB6Jv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QAbuB6Jv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758035659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=wn6ssVhWxqRhAb1qyW/68AnLxAzdOlSixZFYsqgN2sI=;
	b=QAbuB6JvOVMa5G5rsw1/41woSRPVMH7+z2BPvJ66wzcTqtKTfJbe9fK+aBTDL0F7tXteDa
	hBgmiom50lFEzTnEax9xfKDOsr3ZXUUQQbf9GW7+3mCG0juQp+w9nwRDMV8SBPKs/Ts2fq
	DJZ58BlbYjz9/uDMlP0q2/WfDdbvrK4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-a_ehIVgMPaaPBiBcjv1HsA-1; Tue,
 16 Sep 2025 11:14:15 -0400
X-MC-Unique: a_ehIVgMPaaPBiBcjv1HsA-1
X-Mimecast-MFC-AGG-ID: a_ehIVgMPaaPBiBcjv1HsA_1758035653
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88C3D180047F;
	Tue, 16 Sep 2025 15:14:12 +0000 (UTC)
Received: from localhost (unknown [10.22.80.155])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 59A141800586;
	Tue, 16 Sep 2025 15:14:11 +0000 (UTC)
Date: Tue, 16 Sep 2025 12:14:09 -0300
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
Subject: [ANNOUNCE] 5.10.244-rt138
Message-ID: <aMl-wduCwQOAp3cU@uudg.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hello RT-list!

I'm pleased to announce the 5.10.244-rt138 stable release.

You can get this release via the git tree at:

This release is just an update to the new stable 5.10.244 version and
no RT-specific changes have been made.

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 54256839470a39c368c97be0344d72f6f8749307

Or to build 5.10.244-rt138 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.244.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.244-rt138.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

