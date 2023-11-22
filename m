Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KWxD8KZA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6533BB
	for <linux-rt-users@vger.kernel.org>; Tue, 21 Nov 2023 17:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700616232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=IQdeSSYHI2sO+7xQTkbmGKh8goljY3WBX8zI0hcvDo0=;
	b=KWxD8KZAiqHL/ErFrwxj2aqhR4fESdOn7xaqhOZCdaNvmoWaiZ+0XJ5nJF/kCXQXry2Zs/
	p1YPjAoCJa0EtH6Fnylqk8E/z6AoH7dEW2O+4Mxg+r9gRbkPcDlL62kYkm0NL6ZEIDw+0t
	AqUlJzlhF3szOgdb/iA3+ga02PVpUyY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-TceuUw7jPneGJNJQ7_-txw-1; Tue, 21 Nov 2023 20:23:49 -0500
X-MC-Unique: TceuUw7jPneGJNJQ7_-txw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5C40185A781;
	Wed, 22 Nov 2023 01:23:48 +0000 (UTC)
Received: from localhost (unknown [10.22.8.167])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2E75640C6EBA;
	Wed, 22 Nov 2023 01:23:48 +0000 (UTC)
Date: Tue, 21 Nov 2023 22:23:47 -0300
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
	Mark Gross <markgross@kernel.org>,
	Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 4.14.330-rt157
Message-ID: <ZV1YI84M0ynM8Eg9@uudg.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Hello RT-list!

I'm pleased to announce the 4.14.330-rt157 stable release.

This release is just an update to the new stable 4.14.330
version and no RT changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: 7c25b98670e2f172f2813e18a39c02bf13b9849e

Or to build 4.14.330-rt157 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.330.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patch-4.14.330-rt157.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

