Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E876148FED
	for <linux-rt-users@vger.kernel.org>; Thu, 12 Dec 2024 08:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733993468; cv=none; b=Mrr18Da4jxkypV7h6RsTenV0Z/pPVjq21+5dzjRUidrm6Kdf/aru9sds7n3fNIKL32icI3FYIujLwsbQHYe7Sr1S+QfMOlTmWeyUrLcG08mbVLFkrdGWHrGhnZRoQRD2HJ4QOR93EMm8KgVb29mNq6W+gVtVSeMLz/rctFG3qkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733993468; c=relaxed/simple;
	bh=TitEduSW8nmicmgF2JP+dvZMQYuqvM0E95XjHUr+rZA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=GMpxxOZesOnR9P+6jZQB8K03VazGo0TGIHFUixmMOxvkO71SPdYAhkbsqoacsZkN4ljXDp8sQYzGAWi8cNqIlyJuR6orTs5ec+Rqmg0UjTY+wodUWpRuDbfQc0FYT+F9oz/R6OFmUuzCo3mPLMtZMQZ8OIVab+b6J+LWE+3HHGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=3dvisionlabs.com; spf=pass smtp.mailfrom=3dvisionlabs.com; dkim=pass (2048-bit key) header.d=3dvisionlabs-com.20230601.gappssmtp.com header.i=@3dvisionlabs-com.20230601.gappssmtp.com header.b=ZMsX8afN; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=3dvisionlabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3dvisionlabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3dvisionlabs-com.20230601.gappssmtp.com header.i=@3dvisionlabs-com.20230601.gappssmtp.com header.b="ZMsX8afN"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30229d5b1caso2765291fa.2
        for <linux-rt-users@vger.kernel.org>; Thu, 12 Dec 2024 00:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=3dvisionlabs-com.20230601.gappssmtp.com; s=20230601; t=1733993463; x=1734598263; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TitEduSW8nmicmgF2JP+dvZMQYuqvM0E95XjHUr+rZA=;
        b=ZMsX8afNEQkcOnuM1o2tUu4f6o7iY4DbwPL/4XMDzzIHFAna1u2q/PYuUomKC1ZaUg
         M4jeD/Ee856FNg/iJSAkO0JwydLw4IBAcKUsQI7vZdsw+XraauN9bTs1h0BQKtwGjrUZ
         +SCtNPHVzgnklUt0duoeLGTb0GCaAajnytK057ZGULTstWi5PAGQhSx7Um7Vx1xg8gw6
         MTriKa1DeSO1wQClZkFL0XdSfuwd2hDM6T51uzCHztkZUEjue0IwTT0G+BtztexPuYrD
         tACxdUYp1yt2kU6sgCt3ECkIqS/D6cngmV5NMn/u5uPkqR2cvJo5argbkzWkASfHdgoK
         bSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733993463; x=1734598263;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TitEduSW8nmicmgF2JP+dvZMQYuqvM0E95XjHUr+rZA=;
        b=WdqLP7YQ/9SUuIeHYV4IqFMaZ2b6xm1Mr34QDLL+C73/qJJlKnkT9/UMuDHW5c2FLd
         3PPLl7mjBebHttkaMtpKtr5vBlZJY4bizXlib6zFrjQwQTw5rvKnjJADJ4DqT8jV9LDk
         JRS2TV13Mir3tdtSAhiIew2BWp12YVIEeHoi4uFcwEmgJnfimW2gaLnuwOWn3O/G4Td5
         KA6ObILYW1L2Qm7S+9umiRlGeRjlWakKe/fz5O+pTfIL8yyyjMKIbmqWF3IMw+9S3HUY
         QyMqHJm4EtxdAl4O+zR32cZeRUJPn3NB41Zk0EnoZTpfL8RjVhvixcn5jmHhm3gD33ZT
         1d3g==
X-Gm-Message-State: AOJu0YxNhkFOQ2to24aZj6el3VNhZCo/NAxAJUOBfKnpBo/VRmAjTZas
	t3f4qoohINc0FHGlQ0Lupmifu7D2H3WIDJPZZjNqSgAtosjF7gzsgcw93I2rs9XauCJxoITUNRR
	/7+FmeMuJeM6vzPAXwhajwZrB50f9XnhqsYMRBw==
X-Gm-Gg: ASbGnct1UOvadpy9hl5U9+VbuTwipYJnnFpeUTYnIM9AkCHp6+Gb7oOJ8PQRTiwMgEs
	ewKiH5NFwVsn14F3nXG2dBowineuOM4jay2/tQhQ=
X-Google-Smtp-Source: AGHT+IEE6O21kkwlIIkax4heryJRgKIqSzyup3+5LVN4cMnx5ap5FW/5qVXdq0y/fN5AHEmw7r+JmwKVzbbyUsVWkRE=
X-Received: by 2002:a05:651c:1989:b0:2ff:caf8:3007 with SMTP id
 38308e7fff4ca-3024a20f654mr6799371fa.19.1733993463303; Thu, 12 Dec 2024
 00:51:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Markus_He=C3=9F?= <hess@3dvisionlabs.com>
Date: Thu, 12 Dec 2024 09:50:52 +0100
Message-ID: <CAOE-x6Af_0BfPAbESOYQ46oTGeTFba_eBARp92Dudog+5GiEqA@mail.gmail.com>
Subject: Re: Problem with using CPUSET along with preempt-rt patch on jetpack
 4.6 linux kernel
To: bigeasy@linutronix.de
Cc: linux-rt-users@vger.kernel.org, pivezhandi@wayne.edu
Content-Type: text/plain; charset="UTF-8"

Hi,

we have the same issue on a Nvidia Jetson Nano with kernel 4.9.337
(the latest from Nvidia). After applying PREMPT_RT patches, cgroups
cpuset.cpus cannot be set anymore:

# get parent mems and cpus:
> cat /sys/fs/cgroup/cpuset/cpuset.mems && cat /sys/fs/cgroup/cpuset/cpuset.cpus
0
0-3
# create child and gather inital mems and cpus
> mkdir /sys/fs/cgroup/cpuset/test
> cat /sys/fs/cgroup/cpuset/test/cpuset.mems && cat /sys/fs/cgroup/cpuset/test/cpuset.cpus
<empty>
<empty>

# set and read mems and cpus
> echo 0 > /sys/fs/cgroup/cpuset/test/cpuset.mems
> echo 0-3 > /sys/fs/cgroup/cpuset/test/cpuset.cpus
> cat /sys/fs/cgroup/cpuset/test/cpuset.mems && cat /sys/fs/cgroup/cpuset/test/cpuset.cpus
0
<empty>

This leads to the issue, that no process can be attached:

> echo $$ > /sys/fs/cgroup/cpuset/test/tasks
bash: echo: write error: No space left on device

Because docker uses this mechanism, we are not able to start any
container. I assume it's because no CPU can be assigned. Do you have
any idea what could be the reason for this and how this could be
solved? Unfortunately, upgrading the kernel is not really an option
because 4.9 is the latest supported kernel from Nvidia.

Best regards
Markus
