Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1F23CDBD3
	for <linux-rt-users@vger.kernel.org>; Wed, 13 May 2026 23:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778715912; cv=none; b=s3y6npjaCLe6GnpdtZMl8uL8QeXRgqjS8EIaOz2o6Duba/MRy9g1iqZdZwkGu5cW28sy1MaUr1af6sOJTFYbDFHWm+LRClOYa2IWYta4lHPp5R2rP+HKQb9b52JVuCrOfcXX9vywPSdfMapmtWTAJ9e6QqH1ERl0N9PIjnYZFVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778715912; c=relaxed/simple;
	bh=BDpqYGrFsVU2gU04rgxe7so9XNw/uFZzYgK9wvGH8hU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eTR6LiO/zYJef4/EGnQbSWQY/GT/crLO4VP35VkQ1o4nFFFBl3Ob0JGzxI+Sch3BfYvqVTKn1Wrh9ZpFE7bQ6S7UV6Kk4Ps2j7fKzrsmjTXNB89OLjCxCt5ShCjZmeI9NsB4Vybz0NX99UqZm8ZQ3+vDGPXyAFonaHC3z+OZEqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWtJ9Rab; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWtJ9Rab"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-90b2fcf90a0so488414385a.1
        for <linux-rt-users@vger.kernel.org>; Wed, 13 May 2026 16:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778715908; x=1779320708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDpqYGrFsVU2gU04rgxe7so9XNw/uFZzYgK9wvGH8hU=;
        b=ZWtJ9RabrF1FdXaYMZWZJkKYgsFWkIZFHBvYWPvSGwhy+Fkify+7+b81pQq+oymqsq
         uWpBnCYvPlLGHpIQKam44aA0fkDyJjBm5tVWqzKypvKzyhhR2r+TLWY3KPSNHJic8Zys
         3oflfHqUZqSeNo/681JY4H4uIi0wXk5MRNubVlSU7aaZq049AaLFNPR7p6Kn9gzLvpYM
         dSzLJFz9mnYTfCBMoIB2ZP4NdxyD+WCb7qCVrNNNG6jAgydUU2u8Z1Ud8ynUZEcq72hH
         Vryouy083y37nvSm7npxVAtiy4pXCFjSBJ9q4vTWbQAWQM1W1YD5Gza0AZdXJmnHTu0Y
         MrTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778715908; x=1779320708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BDpqYGrFsVU2gU04rgxe7so9XNw/uFZzYgK9wvGH8hU=;
        b=a4Fk5bNZiBI/StfQjHSzO2w6JYTUQDyyuwxBOCbw+QO+2WS883SscYWpoGs3neNkiz
         cbcTJflz0N7ZK9g41JFVL9yy6TLq+39FwUNniYs5il1+7iUt5QhGJjAjROytQS9QSPyz
         mafvsy9BhZYNhKKOo6Tqj7nRIgnkqS+A/AZiQAJyKEJqkIjp3ekb/Z5/fiPBrqZ/GK3P
         ZDx2xcoKfJ1chr6ykq6wsZ/zC2hWoDOlE2Z1wYXFncKa5LHpFHA/kDunWjUV+99LF1En
         G/+A4OOcFI/H5dUAjDHjW6zmEHb6WYtAoJMWvwaz1NMBe30jxpDn7UMhJZyqpROQGb3Q
         hzHA==
X-Gm-Message-State: AOJu0YwLjQhtvT5BYcyi450KwZDhg1zOTeIj39EPedYX/ERX3u3dsvb+
	7c4HD9737STCDI7IP0VGKS6qSRnA3Na94wX35ueUJdKHMTQ4QRxsspv6znuyMQ==
X-Gm-Gg: Acq92OEUlIEja1ZH+ektRRaYI1hVWstv3NL3WfhAsvMCmQ6y1P4aH1SrVffTewfTOkZ
	b8Ymwy5M/OuhUxnTITHw0in17GYJppowRgnXua1fmV0htzwaP6TU3nWxTV6w6pKgtryUnuF+xcK
	aORdXF3vrWyJO7JyaXEoBg2H21rMv2LJr3dLJGXf3x+EPtizurSOINQb6tyEArB36INx2fer4Gx
	cTrJdwEwCQaVTaenIiPycBgOS1YmDXDkI/bbA8lzk3zr37XZmEj99dl1p/tAj5SceglffZpJ+RJ
	YO9k5fRsnf+BZ8XPDqcS4vVxVAsUqixm6cD9wSZNqzWk2CDZyvjSm2YJmzoleih4Ypb4gs0F7FU
	gqd3E+xc36SyyaitvAbiBRnoWcUUu+97pvHutt0HIErPALlZg+l2H+RD7RkgKMBQNQ6i2R93+HR
	9XxB5bn9yx3hQnoveH5dye0efZPlKwE+tM4I3gqcQxnKEfVpGVeiuvdSSTSrfiAfylrmTuE41XY
	yWHSPTuU8dRXhud5D8=
X-Received: by 2002:a05:620a:711a:b0:8cf:dd93:aca5 with SMTP id af79cd13be357-910b0f0ef01mr232809485a.34.1778715908563;
        Wed, 13 May 2026 16:45:08 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910c0ec392bsm84176185a.41.2026.05.13.16.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 16:45:08 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: "Ahmed S . Darwish" <darwi@linutronix.de>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1 00/28] rt-tests: Rework cyclictest manpage
Date: Wed, 13 May 2026 19:44:49 -0400
Message-ID: <20260513234449.253529-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <Z0n7HfDaK5iHOX3m@linutronix.de>
References: 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ahmed,

Thanks for the reminder. Done.

John
