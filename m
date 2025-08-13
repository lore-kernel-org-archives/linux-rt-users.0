Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ACB2FD7B8
	for <linux-rt-users@vger.kernel.org>; Wed, 13 Aug 2025 21:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755119210; cv=none; b=q2oE4T2DaNZwpRSN5NvucM7vZGvFEx7O3pwRN6uiwU+TW2FLYy3Ac7dqkA/oJ7MIBG2H6SCnZ3JHllYAd4H2ayOB4P2UBeK/NTCi/yoOORLlQGYGzJYXSjW3Sko3vybJJoiHRlCU/T2oPCekkOqcrcQLgNQ45OKDZ4JexC17pus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755119210; c=relaxed/simple;
	bh=aqeWIAbV8hWo3NympWFVYFly6MnZE99wE+jfXwvDN2k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dypuO1R4hm5/bDZN0AOZDFl0Ux8iyrrPN5qxPoYKuwRTXFtQouDlICfI836fvW3c9+FRZF0zvKwkHYAfeZizp6slQzxOQ6vlQZX0cczulsACbZc1uBnItx3wPzzdW4TuS9ScfI5S0L4/yMDiV/efqLM8VqlWD78MDkESxB+3DTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fY0MU/n7; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fY0MU/n7"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 138DE1F434;
	Wed, 13 Aug 2025 21:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1755119199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cjt2yicJHLx2/hlZ1Dzeeuvn8rCw1HYIVxWF9whwRqQ=;
	b=fY0MU/n7nbBRELpvz5VoRhdQtYI/n0E5KK2+6bb4CK4trUgL/IuvOANOeXi4Tj3CGpjV89
	yuXPvDKWgWUzdvhNPudHnSWCdSmGCAnVcOVnAGnJ6W7JM9Jc3PQFlRq0X4ISPv9pXSfmlv
	77I1Yk5AzoT+cjuwLMrWM/Y+38JG9emmu/59seOIane/23aG5Vo1YPZrDX5LLjY9bbyG6R
	DyzLzKhcW0c6jO1IJoYBQhbNAcYeDm51P0FEQFiHwdW4BiU0rEcll2r9T1A4hr8mgJKkJD
	TSFq/T16o7y+PrJlawmZWE4pvUckimydINtu75QLyT+7sr+rPPilG2HRvjzypw==
Date: Wed, 13 Aug 2025 23:06:37 +0200
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: John Kacur <jkacur@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Kurt Kanzenbach
 <kurt@linutronix.de>, Clark Williams <williams@redhat.com>, linux-rt-users
 <linux-rt-users@vger.kernel.org>
Subject: Re: rt-tests release tarball location
Message-ID: <20250813230637.19e2293e@windsurf>
In-Reply-To: <bb91bdda-8a07-1c99-5448-706460fdf1ce@redhat.com>
References: <20241228114346.6020d6b0@windsurf>
	<87h66b2c6m.fsf@kurt.kurt.home>
	<20250107141424.EoC5uS6y@linutronix.de>
	<f87b2d77-7925-8678-d0fe-9a0d471a38f1@redhat.com>
	<20250109080555.WpQmRgu0@linutronix.de>
	<bb91bdda-8a07-1c99-5448-706460fdf1ce@redhat.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeelvdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpefvhhhomhgrshcurfgvthgriiiiohhnihcuoehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepledtgedvjeehgeetgfeufffglefhkedvfeduveeiieelteeliedtfefguefggffhnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudekmeekieegugemvddutddtmegrtddtfhemheelsgefmeegfhdvmeeifegusgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudekmeekieegugemvddutddtmegrtddtfhemheelsgefmeegfhdvmeeifegusgdphhgvlhhopeifihhnughsuhhrfhdpmhgrihhlfhhrohhmpehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohephedprhgtphhtthhopehjkhgrtghurhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepsghighgvrghshieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehkuhhrtheslhhinhhut
 hhrohhnihigrdguvgdprhgtphhtthhopeifihhllhhirghmshesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqrhhtqdhushgvrhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: thomas.petazzoni@bootlin.com

Hello John,

On Fri, 10 Jan 2025 11:46:01 -0500 (EST)
John Kacur <jkacur@redhat.com> wrote:

> This option seems the least disruptive from my point of view.
> I am now keeping all versions including the current version in
> /pub/linux/utils/rt-tests/older

I am getting back to you on this, because the latest version is not in
the /older/ subfolder, i.e the 2.9 version is not in the older/ folder.

Would it be possible to place it here, so that its URL is stable
over time? 

Thanks a lot!

Thomas
-- 
Thomas Petazzoni, co-owner and CEO, Bootlin
Embedded Linux and Kernel engineering and training
https://bootlin.com
