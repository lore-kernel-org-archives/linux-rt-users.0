Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E59137DEBF
	for <linux-rt-users@vger.kernel.org>; Mon, 31 Aug 2026 16:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788194938; cv=none; b=gyMYMOIbTB2GDcpSyI6YM7GwIoSSQUTHrcZdhyDyv1QClN8aFk4JYsFYvIEYOTn8DpLOoI3+nqrSk4NBoZ3WNwlH4ashWhQBUx288ihdFn4qIBlS4PxK0q7tjrbR/VOsTBe38cMZFuCb9eJd8z7yVC3NmB88O/ehguZWMCWdytU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788194938; c=relaxed/simple;
	bh=2tmS/tcn7koOzuBoe4JMjt0zqyKiy+P8kh04iNTNY5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bkTvGuvPr1JzllBAO9HSM8OE/3B11Lp76EYyVa90kHYK8NWfZfPRBzuZzeTh1azYO5yFu3oCOQD+zkBiiwr/hj3HJsUMpU++2K4CtJBwfz+LxDhmMj/K01vAjT3M0VLy4/xH2NTJ3I9vpz/1ni2Z0X6t51/GgRAjA0j4kt7ypsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVPMlKzY; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVPMlKzY"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-52fa9c055b5so713351cf.1
        for <linux-rt-users@vger.kernel.org>; Mon, 31 Aug 2026 09:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788194935; x=1788799735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kAFyWjhtD03LOjOLVGODqxNahX5SEgrVYhheG6jDPT0=;
        b=aVPMlKzY8hFKgXblUlnP+C27P01HspGfXeZ/g7mcHYvDHoQoaZ8kxBcefMXeMkhR1l
         El/RvOy08uWr+TY8TrVQ1PmUMVSfdGQyffgpY59zfsm3XkXD0vUdX5E+Gy95qIgMiSNQ
         GflkfTb7IHSDLyE3fTOvikBhPQDU3L0RiHYscUG+81TZH7fPAk1h0vdcl57txRg5cNqz
         2mjcPmSw2IGdiaQ/zGFUwezWOkTGaPNEJXyBguCSiz89/J/N9qMPV/0UaRqvVQcoZzCX
         PKuo7zOYClC6EIHu9BJzTGgiIE6E1eJIbFMuyIYytKf2vDHdOB1KaxlNKdeN9/SlG4wP
         AUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788194935; x=1788799735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kAFyWjhtD03LOjOLVGODqxNahX5SEgrVYhheG6jDPT0=;
        b=eZZJjMtMvCl+OlOzb6HSsYHRm54X1M24kHmx2VhCs8hY1fpyRZdSGc9lmLYznhU8xD
         suAvAyjKMaNwI2HHSKrrXIhOuFKhKu0/Q2CsUHE9VoYKGarSaPlCK1FMl8uPTmw0AQ8x
         LKD8uogJYiiWWZhpCkay/hclBfMDPN8+vv8m808DBCq0LPkSyL6oGEGjoeJFtacL8fHm
         iCnzP7V+RV5m0Bnk9f+tLPWSHk8hnZuRlzydn+5vusBRKXaubpoC6zUiOBKRXEK4n6EH
         yrA4CiLHjUlIv6kUqfHtsG4G+YS+oaBSG+zsyi6DImKzkfJ7lGjXkMnTTZWm7bGxCUrJ
         e5FA==
X-Gm-Message-State: AFuF++lAGw8G7nyZ/ftJOz73+CYtNEto2wCKa3CapIdP0h/KmtbSALks
	PrarQNpnGmGs8oSqXB9fj2AZ92EEIbrNgp78SRQT5pEQvQOcmHConaT0BS41mA==
X-Gm-Gg: AR+sD13HHnoPGQO7OURMUl83bdwP4sy7bF7oO3kNkN/69GxIWQFWBUH6u25ZTcwMlBX
	q4TGEC7AAbYU2Dh2gmshNCKZGuDVggHjBr7fH+pB+uZKxVHE7oIW+ivlBHtaw2oUftNKqBmp7of
	2JuVU3ik/CzZkSQ8b4BsK/lHBxED6Gt4LjuUnFjYp0YfkWaL+S90akFeHl9r2rlTLy+XbW2FFnk
	EGIfhtBFT4cE8QqV8epRdtJaDh34GwQcS63k5+k8efDDxk4PywQBPryVnOFK1Y2726440ft6qVb
	TBSi5ggobtnU7dAO7bUWFb8NeFLPqxdcAW6qM40zqA6MVkz0tcKei2QYbEKC9rTR6CcbgSASJtg
	MG64YzR98JlIgXk9XCe4IKxaaHWb0/BN6SHfbf1VRcB8087TKQiY+7wBSXVweAym1TQIXI4FM0I
	ihNZxE0OXsGno70nzPSGoynFvi+Z0UzP3+F8Hx4vcEbTkiPE3HXIG4R3qp3R+8LcWPqesrK4SUm
	ThvLlkIna31KYTqMRkD+gxajvTLDXXX4bLNq7HfwlFw4MD03DfftOW8Zue0aXJ4mkzG3rRTIs9e
	/kdUto3k5FgoKLjhK9GC/SMZDWBgmSg=
X-Received: by 2002:ac8:7d45:0:b0:52e:125b:9444 with SMTP id d75a77b69052e-5300b8e5b6cmr110199811cf.17.1788194935371;
        Mon, 31 Aug 2026 09:48:55 -0700 (PDT)
Received: from Cumhall.home (bras-base-rdwyon0604w-grc-05-70-53-55-174.dsl.bell.ca. [70.53.55.174])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52fbe830222sm77588521cf.20.2026.08.31.09.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 09:48:54 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] cyclicdeadline: Fix potential path truncation in open_cpuset()
Date: Mon, 31 Aug 2026 12:48:10 -0400
Message-ID: <20260831164810.65457-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gcc -Wformat-truncation warns that the "%s/%s" format in open_cpuset()
may be truncated because 'path' is unbounded:

  cyclicdeadline.c:293:39: warning: '/' directive output may be truncated
  writing 1 byte into a region of size between 0 and 1023

The existing idiom passed MAXPATH - 1 as the size and then manually
NUL-terminated the last byte, which silently proceeded with a truncated
path (leading to a stat()/open() on the wrong path) and left the warning
unaddressed.

Use the full buffer size (snprintf() always NUL-terminates within it) and
check the return value for truncation, returning an error to the caller,
which already handles a negative return.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/sched_deadline/cyclicdeadline.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index f97344035ca3..ff3356a9be3e 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -289,8 +289,9 @@ static int open_cpuset(const char *path, const char *name)
 	int ret;
 	int fd;
 
-	buf[MAXPATH - 1] = 0;
-	snprintf(buf, MAXPATH - 1, "%s/%s", path, name);
+	ret = snprintf(buf, sizeof(buf), "%s/%s", path, name);
+	if (ret < 0 || ret >= (int)sizeof(buf))
+		return -1;
 
 	ret = stat(buf, &st);
 	if (ret < 0)
-- 
2.55.0

