Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA9833BBBC
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 18:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541892; cv=none; b=nHCwjxkH1OmATKgGvWwBCRvviSaiqzxytQKV/HBuce+UfO78nTjJO8r1AhJVbw1uVkagdFA8A1n+BWDPz3iY1vcS2LgDv+W60qbjYecuAPyyy8hMgMxDm9y/+2PU5e7l8dCmZZG3Q3Z5u1YIoS0tdpEwfbpgDSDsYJfEKAyDxJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541892; c=relaxed/simple;
	bh=UQEqBIl9q35Vv7BOvkmw9GVY8m5fOe3S5i9TGJGoDqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ODbMlrkI+WMNKJQCX93zYXYw51vraZN5DgbsEY0UuUcsePRPUgDVi5NpCJAukRfVBlxNEtnW3nGHhK1+V91BiqE114znZ6nhZ9yqTEat7dJ30fYuiGp8vNYwTN/iGFpZqA8e8mIxAzgTYxrC1k5vd5qiHkSClsxfRCC6RCzkvLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmXx0NJP; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmXx0NJP"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ed82ee9e57so14679661cf.0
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Nov 2025 10:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762541889; x=1763146689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpElgHqA1KLkaALPkKmftMb/YdDyD3gnZh4tX4Z8ijE=;
        b=bmXx0NJPPpv89/1Lg8TRtD1jXd0ctSOphcYh7oBTscZMsjrIjnDKQ8cgP4+U/vkzje
         LtopoG2pjnDWLBkxXDjsNbAfNKXZ7x7ZV8iWFpQ9UouOfEVAlZyQEMMQxkX6OhsAJgii
         SkYEEbU2x7KdE3RswRR3T7Z22ghmUTU+3jj6qc1Emi7ZDM1rQLtjGSi2F7LtLB2sMwO3
         PD2Xm6dKBy7kiRI8OrtHjfC8T3A6xtK5B5fEs6/qoxfnVg41ji0kNy8qO1L2SG+u9xMz
         /iBC5HJ73s5bfHB+okywpg94gAZ/SqxfuFnZIwUk0P48pWA69qWMBb53gIuNO2VPj61e
         bHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762541889; x=1763146689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OpElgHqA1KLkaALPkKmftMb/YdDyD3gnZh4tX4Z8ijE=;
        b=Ic0gnwvCv+1ajrSNQ2kDAIai0sZOblBL84DiaklzqLxcckcIkc+riO64+DPYMsqdb2
         itw7eewJyTO36+ByBEYYn6JBmS7721mVklpTSdVB1wy78kNf4KTu3PX8zEf5lIjv2vj0
         Lr2aZB1IFUn+VNK3ECtYZiV7LejAzenNLcdJwIw2edRg+KmXisrDSMsTOp5dWt0sm3QK
         1NUcN11rqrZ9TgQScjlntULdS6FlDASkDfWzscd96wsaQHxqlcrCzo4RSJ71egv4XlAv
         8DRmN6OuHGoVRmDwpxKW1ukU4f2mE5S+JNFHf37ru7kl7+y+DgdjbJV4LUIoa83S4BRC
         IQnA==
X-Gm-Message-State: AOJu0YybsOjG9FOrD2l/pviDZJfdhiT3EJB906aKBEOuCwExgSjLlelX
	QdBXskS2bsSI4Y0Klvom5Z3aTz6Eo7TpwTf9OfVF/5zg7aLUhg4yYEit2LRXtDf1
X-Gm-Gg: ASbGncu/fdu7XQfRuCcQjO6wjHOm65tzynVR9iweUou1Sv/zWZymLVFN8su9qPHHGLE
	Ng9iWCx+0wCBRWAhQxWCsSn1JBODWCtkMmWQEbUt8x/sdeE4a1iXYYOIN4Wcul03YlQf/ks/4VJ
	rDry4kAuEiRVtYgIegIgqcJ+UQkWwEe1vx0b+Hhh4eInV0jV1tyoFj5F/vqt+pjBv8HmyREhGes
	eZY9o7if2Fp1iBGfYGa4KrA3CUJ3h5JiQvfZLi5fERWodDxqpevMXoRL5d+HSk0mg9hupHTxYoR
	yYN0tHOLEW0L0l9SmpsL45UOVtsCgOKJ/fJQ29AWK25rYJztuLMlv1yXFliKcZsCZ9Yg1Kb6E1U
	VNjPHiItIY2GIJYJdGehHU7WC8PbE/7Cs2fQ2EgXg8g55IjbNt3fFSqP1facd9111EciQQYZHhQ
	==
X-Google-Smtp-Source: AGHT+IFRpauhN8f975u2W6kN2fkxSFD+WM8OCh0TZ+qQoJ1LvQ8Js6Ja+ELLE7VEbfX+2o5S0ZWo6g==
X-Received: by 2002:a05:622a:13cd:b0:4ed:6ab0:bd26 with SMTP id d75a77b69052e-4eda4f90366mr1676231cf.46.1762541889565;
        Fri, 07 Nov 2025 10:58:09 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235828514sm458103785a.53.2025.11.07.10.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:58:09 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 11/23] tuna: Update man page with cpu_power command
Date: Fri,  7 Nov 2025 13:57:20 -0500
Message-ID: <20251107185732.23992-12-jkacur@redhat.com>
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

From: "John B. Wyatt IV" <jwyatt@redhat.com>

[1] added support for the Python libcpupower bindings to control the
cpu power state. This patch documents those changes.

[1]
https://lore.kernel.org/linux-rt-users/20250409193136.44411-1-jwyatt@redhat.com/

Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 docs/tuna.8 | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/docs/tuna.8 b/docs/tuna.8
index 242389455f83..6e30537e9509 100644
--- a/docs/tuna.8
+++ b/docs/tuna.8
@@ -24,6 +24,24 @@ Log application details to file for given LOG-LEVEL
 Print DEBUG level logging details to console
 .SH "COMMANDS"
 .TP
+\fBtuna cpu_power\fR
+usage: tuna-cmd.py cpu_power [-h] (-c CPU-LIST)
+
+Set or query the idle (power) states of all or a selection of cpus in the CPU-LIST. Modifiers \fB\-c\fR may be used to pass the CPU-LIST of cpus to perform the command on.
+
+optional arguments:
+  -h, --help            show this help message and exit
+  -i, --idle-info       Print general idle information for the selected CPUs, including
+                        index values for IDLE-STATE.
+  -s, --status IDLE-STATE
+                        Print whether IDLE-STATE is enabled on the selected CPUs.
+  -d, --disable IDLE-STATE
+                        Disable IDLE-STATE on the selected CPUs.
+  -e, --enable IDLE-STATE
+                        Enable IDLE-STATE on the selected CPUs.
+  -c CPU-LIST, --cpus CPU-LIST
+                        CPU-LIST affected by commands
+.TP
 \fBtuna isolate\fR
 usage: tuna-cmd.py isolate [-h] (-c CPU-LIST | -S CPU-SOCKET-LIST | -N)
 
-- 
2.51.1

