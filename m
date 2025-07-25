Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5656B2571A0
	for <linux-rt-users@vger.kernel.org>; Fri, 25 Jul 2025 19:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753470014; cv=none; b=BmSZcQWgmr5rr4PrdL/trLiH3KdlAa6FMPtqJhSuGm/Rx/8igusuzc+YsWzxHx4pk4gRWUjTb1q7FW4ZYFiWiUOQ7xeYpmeQ3wvGx9gYwhMDZZvEMSODN8JqH16jJaFCY1Gmivi4I8ZDWL5zJ5HeUCNFLMKEhQ5XbHR1ECEiBxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753470014; c=relaxed/simple;
	bh=BaiPwRiXK1ft63Dp/o/fV7nKlY9tXj8lJVBhJLXJvXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQ5zWrNAftpMwDD05cd2x8mWFaLf6q18JFj0yNpiS9hryG4OYelqViAP0BYuinNvngcxcAU1H8JfKIgj4zX9qqEOHOHiIkMHFZOEUaUM/902wTtEHu6aAAcARSeMRaVyEL2Dny67lCy0KRWCPrrEeeVjFWNTUFFw4ReZk8/uDBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gc211EN2; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gc211EN2"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ab6b3e8386so26682191cf.3
        for <linux-rt-users@vger.kernel.org>; Fri, 25 Jul 2025 12:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753470012; x=1754074812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfpUmK8DuaGdDmsiUdXjiz3X+22yNWGu1y9BEpef/Fw=;
        b=gc211EN2C8D3MJCdUHMg0YvPkOeeCZPUPAczCQGBP9Kf4kRLK6Wp7UDhZeUQAQAJtz
         TKm/dEaDQxS+h/u3muk5M5vqBCyfSWC4xFf7R/cCtLiaADnmVEBBv3VPsf9SRB00rkFu
         zodWu633AO39DKzFMCd3hG506KOVTvef9jrTm4Zz0jULGhNIcWlgUqnwzoEniFOHnUOT
         DEAz3MI+6EmRYFcgoD851Vs/TxS24z3bajRrDnM8/jKw2oKkt5+RabVeEnAYD+WEFpQD
         7PuNCJLKn9C+94Mj6nHsaZ/Gz3WI5bKvXlDMKE5ygvhaSn67r0OU6Zu3VM2bQ8x0/HbN
         6zhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753470012; x=1754074812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZfpUmK8DuaGdDmsiUdXjiz3X+22yNWGu1y9BEpef/Fw=;
        b=AcWo9h8ea0AG0RDjAqnt04mj39xl+YmZjywMdFt2FO7kV6vmL2fbY1iLmfsE+rUhsP
         eKjDHlrjeIitphtegPKTpbM2/sl+/nqpsWpEUW0KnkLMn734BkW9LlE+IWo1i8aaC5tM
         UAWCNz0htyqYLbrN6ml/NKQuVtRNNpMYjFlKQtV+N04J+ZXodPAlFnBT59WC8OTzdgiL
         enZI888R7HKk1DKu8fmxtzFgKRzhQXU710KqBYjah4zNUn17g+Wqr2sn3IQEciROwe6I
         HG/VYIJoXVY9qPcoUSE2t3YpStxvG7v/IUykC2qXzGw0maAtBYF8gkWaPTu9P2706t++
         uKQw==
X-Gm-Message-State: AOJu0YyPgE+IVcDdaEVtEJTZ/v44HxcaHM1nLpHLMDDhAZq2YJELmvg8
	TJpcPFvhoaDqDgQQN0mnoMDClUVmGV6IFCblLD/MQdWRlCKEB3qdToQDfuMZMAed
X-Gm-Gg: ASbGnctA8GMMwcYmUNLSG+GnBARAk5Ctkuyw5IjMenx/DiaGruz9yq5oqWGZZOOKVGn
	LmhuCKtk0ymq2eF+rgQp1KdoVgaKSuZZMF6faV+C20zp/qjbDkVS9/qyNKALOLE8YfphIeONfXn
	kKZrzSKkJBwlYNQIYz6v72ztDXzpPZlWUdoZbwbziMJ6J34qA4BsGSMYBoxpL7JKQFqaM3cZZv5
	SXWQunFsNvfYGQWK7/CwbjSqbpQ2YokenTvc7lUIQq64QO+jGalrAtAHGSLspCthZp5MLmvi8Q9
	AfepM4ZFRDUY6Y2fZ5X/eKpCCVzHJzmyi+c6qg5y7R4qTqR5h2fih+k+Ok6ZXW63bQ/y8FcHwtG
	OWnywO0S7a8/oEL1OOxxdg4oyqSNru4lgvQ==
X-Google-Smtp-Source: AGHT+IGb/1r/fDmKWKD8f4N2Pi3ypeJ8guaD9GFRE1X1omeqkhCJHlR+hX00XlFm0BkwdRbgKcKcww==
X-Received: by 2002:ac8:5702:0:b0:4ab:9586:bdd9 with SMTP id d75a77b69052e-4ae8f0e228emr52031261cf.56.1753470011766;
        Fri, 25 Jul 2025 12:00:11 -0700 (PDT)
Received: from localhost.localdomain ([142.189.102.151])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ae9966c3cfsm3184641cf.48.2025.07.25.12.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 12:00:11 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: John Wyatt <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/3] tuna: Fix run command failing to apply BATCH policy
Date: Fri, 25 Jul 2025 14:59:36 -0400
Message-ID: <20250725185937.72945-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250725185937.72945-1-jkacur@redhat.com>
References: <20250725185937.72945-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using tuna run with -p BATCH the newly spawned process is created
with SCHED_OTHER instead of SCHED_BATCH

Fix this by calling thread_set_priority if the policy is not zero

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna/tuna.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tuna/tuna.py b/tuna/tuna.py
index d4c3e2c1a661..1380df0dadba 100755
--- a/tuna/tuna.py
+++ b/tuna/tuna.py
@@ -621,7 +621,7 @@ def run_command(cmd, policy, rtprio, cpu_list, background):
     if newpid == 0:
         cmd_list = shlex.split(cmd)
         pid = os.getpid()
-        if rtprio:
+        if rtprio or policy:
             try:
                 thread_set_priority(pid, policy, rtprio)
             except (SystemError, OSError) as err:
-- 
2.49.0

