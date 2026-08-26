Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD0D3C9EEE
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Aug 2026 18:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787770667; cv=none; b=C3E/3i6kdPQmw3DqI/0mtayO6lNvvcc+vVdE1wknzVCdeqE9OVUisf9eN+6SR0VpIMXxV55MjPrGJCFDa2/VTVlCMJ2FcMDuGwXiQT7DzkpB48bUvB8YriAe/LR/e590qZXgajw9K19d/iFzDfhjtfC+IwmsMwBvRc8Nu6nNjZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787770667; c=relaxed/simple;
	bh=eqW9dULQhhU3G7ws54zCceM0EoBsczV+jS1ZQluWZck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kDhS3uKfipgyKWqIjPGkhzw4trtxhHk/XfkCz1c0V/IQTqFFMSiv00spDyOOzpoi6qQlcddj/0fklkqm1sYBG97ynYxq5/oLUgRaVpG6KoxTBDsuAskus9gYQtxoKYY9wX1FNEWEaegOq/sGZ5F4BldmFXducTJE+tUgSr5HkSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ew9SP0fg; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ew9SP0fg"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-517dc520840so11499531cf.3
        for <linux-rt-users@vger.kernel.org>; Wed, 26 Aug 2026 11:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787770660; x=1788375460; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RDUN/CqDH3QUdCprOlnwnW7Ph3YkwVfVnP88nyyY1gM=;
        b=Ew9SP0fgJTCSTA++0z1+h09vu9Z8sahGkQ57iLf5bERBL6R9B7HX5reFwOS85YyeKG
         56ol4f39fq+QSN+p/TdsPxMeAp51rAJXzFVsbhF6RAdYyr6tIHW1E+b30moDuPCtmg35
         OS5UkLX6no55HVfrBw1eWWjh6fBmy8UnVX5lIIRwC8v0fdFRjNrTwPQSDgy079f4Gz4x
         zeSkKJ0EtgVH7iVZP2NLNzlKmjyS4TRKEUVrKyrBb871312t3hwcEy7Xs9vMvblo89W9
         XNJEva/SL7TFPhxn+wExna2pi4J2JO8Uzd2g6+qHbZGkvRDt/GBpLp6eIKkuHciVXGaP
         QhVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787770660; x=1788375460;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RDUN/CqDH3QUdCprOlnwnW7Ph3YkwVfVnP88nyyY1gM=;
        b=DcgikV+Zewsxu0DHL+R5dJBEpcflAljsM6NiRjCG7TSQOahFurcfTx8MjVPqHyWUTO
         XGDqI40iOBRUTtlPXjSjlZE4B2zsBLR/EBud4YE4vz01CcLfaABf0WDz+d2JKHxmAHAu
         4zJnh3NwI2RsOhLELTFqoY2jtN9GfrDLgtsbC6+y0IqwfXLVnREK4yB20qmNyYBKCMSm
         Al3i+qtFKnJd9n30AnPL/IP+VGWiev2JXXlyHXPd88onZFE748lColfANMJngB7xUuub
         RjnJF/0Mb7Zcj6fMmJPqy0MgC4cpf2XqtjS/QOvT/Y8HUwFvJ5KFtdFLAfHbiTYuHkPU
         o/Sw==
X-Gm-Message-State: AFuF++lSOMNdnB/2sQGpy8dn2dp5RGCMN+M7u5rg3YPxxfq4Q0pgbWoG
	7lKMqwq/w7+j2GoOaEvXiOetsPiYLu1Ps4ZvLCJdauQvhvUrWGCFkpLs5nUxB64L
X-Gm-Gg: AR+sD13et7g9xbVKyEWQoXmGHJw3xOLTMs7ejg91vpovhQWojKDWn9FTixuJFibjc9Z
	0Rw9XhgyAyqW5Wt5uE11j72WSGDYXJ9e/bRjJ79RO3mDCqf0zdsxKGjyprA+GQyKtlXcYQwmS+y
	9WoeBozzteJletUjeC+HokdOP7q5VUrUUdA4lsReCIpXxoEPjKBYjjQuXtSnu0JzzlgC1CIC+h4
	cRaTbkcH5jLijbPpMnFB+M+gg2/KI3xJQhAaGSve6p3iLipnKXM7cUr1sTp9ZlphZqAzTQNue4D
	zjsmkjgfUST+nvwCYIQqEUwQZjfSW5MZNKcaAVHv9sjE97FEnUOogz+GzBZWOnuQuRzsIuWEc6x
	BSrR//SZ5lpZ5WtajQWj+Q4Q/14mxYSZcQ+/dX0+svsrSHXDjINhvKljBRlEezEHatvqjdo/nSq
	tRRhBx1U87DqbFYVbWKxw1we4RmF/01BrMyU3rjChu+kPFZKZEJCgP0RssM57H+FfDmzMCdFFQz
	AYcXf5OC0eEAMWQQO2PQ1EHQdCew4fglE/6pNGxtwofAAzEzQ0Z6Avz9wAhJADev+dH+akJRy1r
	9EekUJeZLlbBD36osQjodYwqOgz0FFCW0bNX2Ub+8A==
X-Received: by 2002:a05:622a:2618:b0:52d:cf85:aeea with SMTP id d75a77b69052e-52e423df762mr109569401cf.24.1787770660104;
        Wed, 26 Aug 2026 11:57:40 -0700 (PDT)
Received: from Cumhall.redhat.corp (bras-base-rdwyon0604w-grc-05-70-53-55-174.dsl.bell.ca. [70.53.55.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cc6507f13sm32593386d6.32.2026.08.26.11.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 11:57:39 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	Sana Sharma <sansshar@redhat.com>
Subject: [ANNOUNCE] rteval-v3.13
Date: Wed, 26 Aug 2026 14:57:32 -0400
Message-ID: <20260826185732.208384-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I am happy to announce the release of rteval-3.13
rteval-3.13 introduces an MCP server for AI-assisted analysis of rteval
results, along with stress-ng usability improvements.

New Features:
* rteval-mcp - a new, optional MCP (Model Context Protocol) server for
  analyzing rteval result files from an MCP-capable client. It provides
  histogram extraction, percentile and per-CPU latency statistics,
  result comparison, batch analysis, filtering, and log-file access.
* stress-ng stressor validation - invalid stressor names now produce a
  clear error pointing at "stress-ng --stressors", and a helpful message
  when stress-ng is not installed (Sana Sharma)

Improvements:
* stress-ng: apply taskset to keep stressors off the isolated CPUs
  reserved for the measurement threads
* stress-ng: updated parameter names (Sana Sharma)

Documentation:
* Add README, demo, and enabling guides for the rteval-mcp server

To fetch

Clone
git://git.kernel.org/pub/scm/utils/rteval/rteval.git

Branch: main
Tag: v3.13

Tarballs available here:
https://kernel.org/pub/linux/utils/rteval

Older version tarballs are available here:
https://kernel.org/pub/linux/utils/rteval/older

To accommodate distributions that require this, I have linked the last
version v3.12 from the older directory to the current directory

Bug reports, patches, etc are always welcome.

--
2.55.0
