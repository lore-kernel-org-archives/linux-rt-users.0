Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90109244693;
	Fri, 15 Aug 2025 13:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755266284; cv=none; b=azplKoBHkfW6vMdrpdENGCy/9AON+3vqpcOTabdu8n0+LzfAn3Msbk7Zc6wrfEbjpaXXoOWvLMNDgfSYj6cPIwPYzgL5GEPn1tmzCSVhwXbQxyo1JiGaHgOAc2HlUxwAFLsuLonxG6jpLP5zq0jp51NNG/PVrEfh7UQYrT9hemw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755266284; c=relaxed/simple;
	bh=3i2XwEiUWtcY9tVi2Jo9ocqkzPo9A5lYI1mOmRJOiDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Wd5QkZ7rQ8GHfNPErwvf54QjIRkccZsim0exCtCe+tIdW/R7izhdhh3xuNYDltxOA7FSQvAd9p6o8Kj2uqN4cPpA1bWAe7nUJvEG/rOo+LcBg+eIAd+o0T+ixK7358y9r9HmgnouNS898zxDv3d6uhgnmsBWZQU1Yq5nflyjU4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZAYDx33I; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=slhFL3Vu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZAYDx33I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="slhFL3Vu"
Date: Fri, 15 Aug 2025 15:57:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755266279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=nyvcUS+/2o+Fhop1KJaZB0aAOwF9swOXW+69NmOfClc=;
	b=ZAYDx33IOxlrrz+Nw3yhp/YSiYN8FJKNWJKnana9cSzTQEjlfIF/CENaK67cJcTAqEbiCz
	6rKX5F1y4gg/LZbn+GM6S2S+ugjEx0L3OgVtA7FEC21dpIPfyut/KAqOJT7uJijltQrFni
	J1kcSmtUJqtEd2G0UY53qIjqsk4hmNeCpb41He4vDo6UrRJgdkUgXvK/HZEZJAGZX+l7xQ
	t4qaIEs7mai57tl0HZkEmixEEVPvSlVlRTdydzvg0Qf1eSvazTCOTUOoKYo6iYrTXthjRF
	2Uhm4VBICAe+roWMe2/7txnMgkIe1keZhYsyhSL6E7sHtRdL8yTWoZTQx1zIlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755266279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=nyvcUS+/2o+Fhop1KJaZB0aAOwF9swOXW+69NmOfClc=;
	b=slhFL3VuCt4g9zI2YeoqB9lFcLN34mH6MNprjUqIJ2F221NqdlfO5tBqkln3XXKa+zoWHD
	RMtwCCdOEvhc6vAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>, linux-rt-devel@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.17-rc1-rt1
Message-ID: <20250815135757.yZK2felP@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.17-rc1-rt1 patch set. 

Changes since v6.16-rt3

  - Updatet to v6.17-rc1

Known issues
    - Yoann Congal reported a bit spinlock in dm_exception_table_lock().
        https://lore.kernel.org/all/Z8GTjqgDe_5EkE3t@P-ASN-ECS-830T8C3.local

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.17-rc1-rt1

The RT patch against v6.17-rc1 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.17/older/patch-6.17-rc1-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.17/older/patches-6.17-rc1-rt1.tar.xz

Sebastian
