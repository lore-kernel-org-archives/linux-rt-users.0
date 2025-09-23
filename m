Received: from sender4-g3-154.zohomail360.com (sender4-g3-154.zohomail360.com [136.143.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1373118BC3D
	for <linux-rt-users@vger.kernel.org>; Wed, 24 Sep 2025 00:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758674103; cv=pass; b=q5JbPpvSVazyYpMjl0FClos9gMBihHEjC/hawdUVHL+dDTDSFTGW0tOTwCX/tsIwt9Bmv8SYzMsfueOHyeAGoj04HOn8+C+FEUt2tP8W4SMrH4LThibatVD6Utzeco8OQkEmR1xebuaE+8bj7OqH0+hMgDSbd3U0GbOsH6nwkMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758674103; c=relaxed/simple;
	bh=jxWuB9qIjPTxSwaKK0EfptitCHwu/M+YCHnkbceEOIU=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=Eo8NfoRc1NqXouK3iTe70f3no3M6jly4WW1zoFeRnkpsENEX6AnyUNGR7GF3g+vVAk6s5xBXhU4TvdfmvaUGOLYO/IXq9a7s/oB9m+oZcNl8Xko38YP1J2oHeh6VvHenSlzrLpLdy4JTtAVgg603pqGe9CQQ7nn2Gv8obDwmSJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx; dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b=U+9++Ot2; arc=pass smtp.client-ip=136.143.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b="U+9++Ot2"
ARC-Seal: i=1; a=rsa-sha256; t=1758674101; cv=none; 
	d=us.zohomail360.com; s=zohoarc; 
	b=HRgUKibc57SCrUJeqI7ty0/fQhXzX4hBN6mT0CRzDl2yrMncspmbfPMo1FRlDq9zPiYiikXxQGyyYuRcPyCVKsC1lGE6cknCdgtrL9jUrq0dqyprgyxszHrBbq4GFk/YhXjv/GPPO9XIOCKQdnMbvVQLgqiPxTqmyYvM75MQ2UE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=us.zohomail360.com; s=zohoarc; 
	t=1758674101; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Reply-To:Reply-To:Subject:Subject:To:To:Message-Id:Cc; 
	bh=jxWuB9qIjPTxSwaKK0EfptitCHwu/M+YCHnkbceEOIU=; 
	b=tyT+p7RUxVStGfyoRFqebqLybmV/fz0m1CkCA7ga42hqT6KuBFQdMnXkrei29aqcuZqNPx4NnqPxCoAyH9n4+QLCZY3TIKznjBdJqin1ltFC8/WFZbxGO1e+0nUe/DZvcn73uFrZX7/nRVlmMOAzrThzSLZrhtvf3G9QmyZE/Wc=
ARC-Authentication-Results: i=1; mx.us.zohomail360.com;
	dkim=pass  header.i=maguitec.com.mx;
	spf=pass  smtp.mailfrom=investorrelations+9aaa1100-98d8-11f0-9ce0-52540088df93_vt1@bounce-zem.maguitec.com.mx;
	dmarc=pass header.from=<investorrelations@maguitec.com.mx>
Received: by mx.zohomail.com with SMTPS id 1758671653443708.6546900027258;
	Tue, 23 Sep 2025 16:54:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; b=U+9++Ot2XODIIlJJyxCpIXCorbLrbB5RIdQKfu3krri40eXysnbAPPIv/7M2GkUDtyIEtErjC0xYyzKFyhlsCRx9jRjD9S2jr76axb9zhX1q+Bpli4Ga7qcjUi8K9j4xFL3q251UssuW2RhlMCHlRg6Bwbkvxtoe2hmEjymILeM=; c=relaxed/relaxed; s=15205840; d=maguitec.com.mx; v=1; bh=jxWuB9qIjPTxSwaKK0EfptitCHwu/M+YCHnkbceEOIU=; h=date:from:reply-to:to:message-id:subject:mime-version:content-type:content-transfer-encoding:date:from:reply-to:to:message-id:subject;
Date: Tue, 23 Sep 2025 16:54:13 -0700 (PDT)
From: Al Sayyid Sultan <investorrelations@maguitec.com.mx>
Reply-To: investorrelations@alhaitham-investment.ae
To: linux-rt-users@vger.kernel.org
Message-ID: <2d6f.1aedd99b146bc1ac.m1.9aaa1100-98d8-11f0-9ce0-52540088df93.19978ffc610@bounce-zem.maguitec.com.mx>
Subject: Thematic Funds Letter Of Intent
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
content-transfer-encoding-Orig: quoted-printable
content-type-Orig: text/plain;\r\n\tcharset="utf-8"
Original-Envelope-Id: 2d6f.1aedd99b146bc1ac.m1.9aaa1100-98d8-11f0-9ce0-52540088df93.19978ffc610
X-JID: 2d6f.1aedd99b146bc1ac.s1.9aaa1100-98d8-11f0-9ce0-52540088df93.19978ffc610
TM-MAIL-JID: 2d6f.1aedd99b146bc1ac.m1.9aaa1100-98d8-11f0-9ce0-52540088df93.19978ffc610
X-App-Message-ID: 2d6f.1aedd99b146bc1ac.m1.9aaa1100-98d8-11f0-9ce0-52540088df93.19978ffc610
X-Report-Abuse: <abuse+2d6f.1aedd99b146bc1ac.m1.9aaa1100-98d8-11f0-9ce0-52540088df93.19978ffc610@zeptomail.com>
X-ZohoMailClient: External

To: linux-rt-users@vger.kernel.org
Date: 24-09-2025
Thematic Funds Letter Of Intent

It's a pleasure to connect with you

Having been referred to your investment by my team, we would be=20
honored to review your available investment projects for onward=20
referral to my principal investors who can allocate capital for=20
the financing of it.

kindly advise at your convenience

Best Regards,

Respectfully,
Al Sayyid Sultan Yarub Al Busaidi
Director
