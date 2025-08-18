Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9890878F36
	for <linux-rt-users@vger.kernel.org>; Mon, 18 Aug 2025 19:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755545716; cv=none; b=nuVMWRaJOPv1Me1IISkf0nWLXGYOg1xJ5qbYwOm2y2eRvGh/EdOHMg8Fjxjlu3i9z8boAPD1CfxUPUCRqAe2e+uuCQOJB95JLK5eRCxxji88Zg92FTkXQRDYxBXKAsS7ayxQrco9vWnh5qC6WOR77mM+W7OoHmKboH9O1o8fgcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755545716; c=relaxed/simple;
	bh=m8KKijx+LNJZK2QL8CNWAZGWpgLVUPX4F88CrIO8oIY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nlU7eyLP2CaYXxKwXOunZrasJXVy1D/tM5Z/GRWBoEOM1vkTlFZk1WwuWM34T44t0kAW5eVRoUWWmQSXiHRC595oNn5772iwt45zb2DBqjinKoRoGfyTz0CwMGuXa684E5ktMlaakCw60xHylUb4CORNI03veddaDK7q7JqpCYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JQ0yBL5l; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JQ0yBL5l"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B88924E405A3
	for <linux-rt-users@vger.kernel.org>; Mon, 18 Aug 2025 19:25:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 77512606A6;
	Mon, 18 Aug 2025 19:25:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 06F6D1C22C561;
	Mon, 18 Aug 2025 21:25:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1755545111; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cIkCNtNlkipIDoQTMysSj6ltPg3uQxvhAUHTgBppA/E=;
	b=JQ0yBL5lx+ZXh82r3oCXAOEVj/D5vmWqAQC3vlvE7z52+riTra0dmypTbgFS8SdXz9OwGu
	VT6a3lngIbyuERtX/5UCYisI9HHbFAp7qWZEuA7WHSv3XU/0DM4AO63gYC0eDBSqIyXPTW
	ijkzp8TtV2bPNWFLKc4j0kEY0ZcPJ9cXb94HpHOrkcRRsqH3QD8CBgSD1bwLB3XaAh8OwH
	/m7VmryBDr7ox3fBRP/4IE5xzckvyhXIVTELuJm86HLmVEHBaZTeGe8OYgkGXj2RpbTILX
	RHd1R5v+OzmVGzZtYqkQ5TUv+VKIAIaR9WL7A5olF6IcWTzVJMckCmGmifeSHA==
Date: Mon, 18 Aug 2025 21:24:58 +0200
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: John Kacur <jkacur@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Kurt Kanzenbach
 <kurt@linutronix.de>, Clark Williams <williams@redhat.com>, linux-rt-users
 <linux-rt-users@vger.kernel.org>
Subject: Re: rt-tests release tarball location
Message-ID: <20250818212458.5b22df0b@windsurf>
In-Reply-To: <af905835-5920-366d-c41c-749555f95200@redhat.com>
References: <20241228114346.6020d6b0@windsurf>
	<87h66b2c6m.fsf@kurt.kurt.home>
	<20250107141424.EoC5uS6y@linutronix.de>
	<f87b2d77-7925-8678-d0fe-9a0d471a38f1@redhat.com>
	<20250109080555.WpQmRgu0@linutronix.de>
	<bb91bdda-8a07-1c99-5448-706460fdf1ce@redhat.com>
	<20250813230637.19e2293e@windsurf>
	<af905835-5920-366d-c41c-749555f95200@redhat.com>
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
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 18 Aug 2025 15:18:26 -0400 (EDT)
John Kacur <jkacur@redhat.com> wrote:

> Done. Updating my scripts too.

Thanks a lot, much appreciated!

Thomas
-- 
Thomas Petazzoni, co-owner and CEO, Bootlin
Embedded Linux and Kernel engineering and training
https://bootlin.com
