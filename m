Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6982382
	for <linux-rt-users@vger.kernel.org>; Sat, 28 Dec 2024 10:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735382996; cv=none; b=kozpZmQiinVXXrC3scHpsMB0WaCOUkfbc2pXrRr3eVGX1/m6lafiP+OJ0NOsfEQ+9Xgo3f6nijXfNwMcwxjRrvcSORmScS5ZDzCVrbsYIOMVVCwrkx090c/M/h/RPQ/mdQshaD3H7xxN61iIiGmRIaSrn6l2A0i6ha1pSI6DCTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735382996; c=relaxed/simple;
	bh=O59jQyYaKEv0mU3gPUpZs2ZxpvaNzKsBYsmPjzs477o=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=gBw1f2cRc5dcl+3jyMHrpIJ1yNHEykvs5C/h8Qg1xmTuK7Ja7y4qMrKHmYdIcnDor816mxfFhoOIqUyjGTHV3Dyz9rhKT+YdNQ1AAz58C476Vcv8ORiko9nfXFiqx4AtRS5BI/Sn2hJmEKQ43B8Yy+MBAlYN6sXevA9hgc57kMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XiHUBxK8; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XiHUBxK8"
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id B1C35C1186
	for <linux-rt-users@vger.kernel.org>; Sat, 28 Dec 2024 10:43:54 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2D049C0002
	for <linux-rt-users@vger.kernel.org>; Sat, 28 Dec 2024 10:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735382627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Kd4BNyypYe7ktNcbnTrJJZvQ2DrkgC/Ik7iuzuoLPb0=;
	b=XiHUBxK83f90dnyCfyK4D/y8yc2CGNOJXe1pZFBPk0ps+ScRyxWVNH6RohQmMcNnVrWICG
	tWfxgWwHUS4IdtUFVoMd2xLOPzNjI7eXc4SVffOYLgseo5DlxGUKmUBeru1uWKU7kSvCt6
	7pNJuh9ctoVBmSvHulseoAoq9JBeXuHW2JVyx8KcXzYYiH/XUJ2tjOLm3JabNDDr6xoVGr
	jswmCU1OlUBwEmGOPxWx2gZ3wGhxHnnLTAwT7tQETIwrj7CHIqqFdr31jrzWGw8NWSv361
	DI5Xm1osSIvAGmWz9SN7ovmT5DsaZRNiUEJtLNH6G3Ip5jWqpyXr8Uoqww+yMw==
Date: Sat, 28 Dec 2024 11:43:46 +0100
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: linux-rt-users@vger.kernel.org
Subject: rt-tests release tarball location
Message-ID: <20241228114346.6020d6b0@windsurf>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.petazzoni@bootlin.com

Hello,

I am one of the co-maintainers of Buildroot, an embedded Linux build
system. Among many other packages, we obviously have rt-tests as one of
our packages. When rt-tests is built, we download it from kernel.org.
Unfortunately, the rt-tests tarballs are moved around: the latest
release is available at https://www.kernel.org/pub/linux/utils/rt-tests/,
but as soon as another newer release is available, the older release
tarballs get moved to
https://www.kernel.org/pub/linux/utils/rt-tests/older/.

This breaks the build for build systems such as Buildroot, that expect
a release tarball to stay at a given location, and not being moved
around.

Would it possible to keep the tarballs at the same location? Either by
not having the older/ folder entirely, or by populating it immediately
with the latest release, so that all releases are always available from
the older/ folder?

Thanks a lot for your support!

Thomas
-- 
Thomas Petazzoni, co-owner and CEO, Bootlin
Embedded Linux and Kernel engineering and training
https://bootlin.com
