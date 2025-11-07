Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E92433C53F
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 18:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541904; cv=none; b=ADVBMCS/NXRRiCtIXwWGqCGzPd1QBC0VW+u6c9qIiiAbTG4+Nm4EOfm70JX/2IvOtvaAFtncGkm8dge6+meBSa77+VuU/Kmtje2urZyA0xHSIHIwAl5sEvEvkaAoPNeAImLzISKXtQQGoMEHfTqIz0p2qEOTFpeL9lSnTaBU2k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541904; c=relaxed/simple;
	bh=CfKWDzCa/obPyKrhl24N4u8B+N45dW6impYlHyKKjOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltzPwfM7AfMzcD4m3L8pHI66d02tU3+opqdGShQE0xm8+y0usKnLuc8aDiA5ActHmRUCi7kKYZuyeezl4wwH+wx7HxqbMpCxT62KdJ3S53et38G0iu5XOq/ehpfTiJKlsl8Z8NP9P9knHBMlhVCcE929IoZn5LXpW+apwumcDHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6V6z9Ef; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6V6z9Ef"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b22319db92so102506185a.0
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Nov 2025 10:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762541902; x=1763146702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEQxdnbF2hLfSRt27g2JGuMwCdYoJjuGxSpxst3WiZ4=;
        b=L6V6z9EfZmhUNUC1cHKEsrd789obIrcVQuED9gduNBLnmCnJf8dtg+Na3xImFy0ZrE
         DCjchfQeOp14LQnSpUO0EhFDb7iEAWCxGCUdDJMYWhNhsHpx3d7sFb0CTkm2wK2WGarw
         lcwQx8OKGHzVA/oyxpuuHPzJyGpSg3vdchLNxa6dLWntcSO1PhjJWYWQmjb0F+9n3oiV
         ojoeL9+M1KZm4mdY+hdqPGSXiD3KoHzkc/3SLNOEZMVV2ESrIFrQybUVqE3llNGMLWFQ
         Id8gdc5pqUyIOgIdLkDJE1FNHEDIcFI2naMaTvJ6Frzt8E5f625xhp9Yg4SIthmNqcsG
         qksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762541902; x=1763146702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UEQxdnbF2hLfSRt27g2JGuMwCdYoJjuGxSpxst3WiZ4=;
        b=s73GWQynQIM1+m4ZGKXrCRnUxM1FCNSKjd6zT3m3Dzmd9rpO9fsndUzl3WF1ENCv6c
         ZNdGCW4M0Fr096OQsCz1uTcxk/vLvvrmU8jbtL/7O4LOjNtBulOgN5hgvGUNyz9PQXN9
         XRahQZAFY+11kbamTq4iaSf14Lo8Lqdg1BzY2yfs/8sOdyWLgPs4K/3XFEAbrznlKG8l
         hDpQCln7iXz189FeAi6Ux64/orJP01EmYPz78c0DAT2MzZcZqBcCTb6XC0WPmUilv29q
         b0T2TEZiKMes7Xc6lQjmxexsA4jFynamEXZ7kZbdoeLM6DoBiiJUuGvJLxluDmuRq6TH
         xHPA==
X-Gm-Message-State: AOJu0Yxc05uU03lMoumcQTo48VeLu8ZEuhBl4SfFcNz60qncxDjsvD6o
	jJeQstUrnRxXnWJerZY/wr7AcULqJ+TK6F+Hea6smZCHuemUQC8oUvkxeAVtQKJm
X-Gm-Gg: ASbGncuYHdXdytHIktcm2JTTK9dWKtT6GHwP6xyVDOeqSgucjQWNUmLqidzca8+agXe
	4eQs4n88OmZaNnQDGT5PxBiogMxD1Jn2yFr2iNB2ZhUBPJPj5AkRQfuwEymTLyrB1hoTrh7xAbD
	xb9xMv1lGAR7htlbYKKpCYnRKi7Z/6YmGBljq143/l10N5l171IM0Z0ZqMVXzJztXfn4WI9emhm
	dCvfwWO18j8HH5rSiiS9yqOYkZwkay343o6wjQJZL4JUqWVGUhCYsDpii/4M8cWzSu668xVBItr
	XNb1UmWwk1pioib1fyg6IItk9Do4BQ0hTWnBTbda+bncZK8UC6VMrjX30ZYa869UbnLLX4djGi1
	ZmemHgC+TrqHB57BAhWEXYFKtjUSw7pd/NmPJ1QcI4wW0IyWmPHp4VSix5l7uVwv45NDnt0tWvA
	==
X-Google-Smtp-Source: AGHT+IFlvqoRrp1RTS6ne4nw8aJzgezGU5v/b2SdV4dT6sjrRheItAjByxTQpRtZV+4jETVX3Wc30Q==
X-Received: by 2002:a05:620a:3729:b0:8a3:9a05:ec15 with SMTP id af79cd13be357-8b2577483cbmr74307885a.19.1762541901916;
        Fri, 07 Nov 2025 10:58:21 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235828514sm458103785a.53.2025.11.07.10.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:58:21 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 22/23] tuna: Update version to 0.20
Date: Fri,  7 Nov 2025 13:57:31 -0500
Message-ID: <20251107185732.23992-23-jkacur@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107185732.23992-1-jkacur@redhat.com>
References: <20251107185732.23992-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update version number from 0.19 to 0.20 in all locations:
- pyproject.toml
- setup.py
- tuna-cmd.py

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 pyproject.toml | 2 +-
 setup.py       | 2 +-
 tuna-cmd.py    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/pyproject.toml b/pyproject.toml
index 8333a1acb913..95ec65c55195 100644
--- a/pyproject.toml
+++ b/pyproject.toml
@@ -4,7 +4,7 @@ build-backend = "setuptools.build_meta"
 
 [project]
 name = "tuna"
-version = "0.19"
+version = "0.20"
 description = "Application tuning GUI"
 license = {text = "GPL-2.0-only"}
 authors = [
diff --git a/setup.py b/setup.py
index 00a79727ba02..b85673056c9f 100755
--- a/setup.py
+++ b/setup.py
@@ -16,7 +16,7 @@ if SCHEME not in sysconfig.get_scheme_names():
 PYTHONLIB = relpath(sysconfig.get_path('platlib', SCHEME), '/usr')
 
 setup(name="tuna",
-      version = "0.19",
+      version = "0.20",
       description = "Application tuning GUI",
       author = "Arnaldo Carvalho de Melo, John Kacur",
       author_email = "acme@redhat.com, jkacur@redhat.com",
diff --git a/tuna-cmd.py b/tuna-cmd.py
index 9f5ce918054d..886824a4013c 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -102,7 +102,7 @@ def gen_parser():
     MODS = {
             "logging": dict(dest='loglevel', metavar='LOG-LEVEL', type=get_loglevel, help="Log application details to file for given LOG-LEVEL"),
             "debug" : dict(action='store_true', dest='debug', help='Print DEBUG level logging details to console'),
-            "version": dict(action='version', version='0.19', help="show version"),
+            "version": dict(action='version', version='0.20', help="show version"),
             "threads": dict(dest='thread_list', default=[], metavar='THREAD-LIST', type=threadstring_to_list, help="THREAD-LIST affected by commands"),
             "irqs": dict(dest='irq_list', default=[], metavar='IRQ-LIST', type=irqstring_to_list, help="IRQ-LIST affect by commands"),
             "cpus": dict(dest='cpu_list', default=[], metavar='CPU-LIST', type=tuna.cpustring_to_list, help='CPU-LIST affected by commands'),
-- 
2.51.1

