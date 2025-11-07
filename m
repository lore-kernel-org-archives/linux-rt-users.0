Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7356E33C515
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 18:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541896; cv=none; b=jMTNfpVw7yT2XYgirLZwGg9E5+ctbeE0+DBikuu9IpPveoqmfQ0FQkuMbvwQZbXwDwLvpsrPjgiEVmS2oE8DbQcyEY4Kf+LXiph5+rKWdLTz/82v3cUMO4sjvbi9owDaNvVoGsr/VnObYVrvd36XWJP4ACuNyuWsMSAAmz3sPMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541896; c=relaxed/simple;
	bh=dVaGdt447zQj+7d2mr3wqH4Arwue8/0TqOYlrCXrdpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KdezlhbTdTZejD+SEitTHwKOQawxt47xIlHHfvK7rE9x+Z1nkpM+sG15onf7Sc11WS1/MuUtRs5g3Y0D6FpJcFSPfzorG1v2Gz48Undfaiocj6zYUuX4X02/tLoU9bgepl/J5ht3HZ0cv8XBV5buRaCjDJuxxxvqa9sTxFoPduo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcCwY6jX; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcCwY6jX"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-89ed2ee35bbso139647585a.3
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Nov 2025 10:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762541892; x=1763146692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcEgNpVUlJDsdIkCvzpyQGtJ1wFl33wBMT6wmAoMDkw=;
        b=kcCwY6jXlHXzqYM7YuA1mKOWpV7bfXQUtC+fWN1DMZAYK5wo9IuFlzVwVPO/hiAg2p
         LXrumhEy5+mjpTDDW7T8vLFgAeCI8OZ5fCIZAsdDStIR/X4lL7KwZvxQnsMABBm3e/v2
         4dVf68uMg5tluQ4n6rg9mau0fBmOAhzwMtj9Wb2V4CNy7amM2sUJFrptR3/+pYNv+WLp
         eMxxn/Uz8C26T9Py5zA8PPZFV4tkPIa3Sp+gh0Q+avKb4QMhct4437eD7wY7LUHXJ45i
         PsWwzHDQOrLLHiqhOEjB/OiQobRvio0MBWAhjJ0ekZjzUeDtWC3hY1fFyvn7ilZRjiZ/
         X9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762541892; x=1763146692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LcEgNpVUlJDsdIkCvzpyQGtJ1wFl33wBMT6wmAoMDkw=;
        b=XVah41Su2ZhRazU+sDEO17FmRXRp8Mp7Z95RzJ8to/g+Tqcdl/v+NRO9sPinrXpUlR
         xPpgCR/B3hJek4z1TYh/xRmvseYaDevCl1qt0WDmrCkqTn9hZ2nMmmWtNQfzPejRr/W+
         oAiBr0pYNBTGiFELHqs4Rz65S/z+nitM0rnTG/uF+acTQBQhMcIlPBxotb+7bGTzmuoS
         m+IBgYtwAoCiYF0bV7iJ58ZGQfNj74lJ/Ld/v4kCbq79m0XCw9bJ9ZiVhgBXBFbc/pKK
         pVf3hvKb5Sml1zHZjzkFvWiQAZto1vZWUr9iN9QJCzgtc/edFSH9FyxFJltumFO38tc5
         Ueww==
X-Gm-Message-State: AOJu0Yxj4iJoU+OJPE31kOX3Oo5RiJqcy322sKZdFApT9iAeOUuMvXUT
	1PqX/YabzW4aJycFqLznU3wgj+ZTHvnU6x6Gj0fA/2JDclc8Y7+qnn6FGsoMsoIz
X-Gm-Gg: ASbGncuSiqJvQw2PGAUebg6LCydpFwGJQXVL1J6dh/gC5DzNubgZFdrpcN08jdgd+0Y
	I5nQ5Bva2gBkjKvs9fMsrCItq4DYSg5DjuwfDFOD8zkfS2R8EikZZ4sstcv5dNozPHEA8xIVJrR
	ayTERJLPQpCHOfRX1YhiGh3q0WgWNjgWqrO7XycW2SI3I7ZhCKA/RT8lsWo2SvFUlLgEMHcBOay
	OAe6Q89ckyKqAYyspgHZbpBLRYli0t1cgwF7r6+Kc03Y1FMUbO1iAbwUVpP+LdXNrFB3mLeqOqL
	6quqhnIhW9CPQUX9U8fLvPyDbSWbdlnsHYtGhml7JZSR5irO/vr8tARnnUG0EAe6sf7h2JAF/cn
	JEf6aT05vdz8ZWa/AgAZ0/4D7WwOdOLatJqHEM2NJ4Wrx5fpZ/nhb3Y4ChyesxY4eif4GR1O7ZQ
	==
X-Google-Smtp-Source: AGHT+IE7E9fYlLrrX3PH/xdy95MPFk3Y1pzXsfOYilJK3wtdVUdrbihcI9w3Cp1O0feDSqdUfJdq2w==
X-Received: by 2002:a05:620a:3710:b0:8a1:21a6:e045 with SMTP id af79cd13be357-8b257ef47c1mr46538085a.19.1762541891938;
        Fri, 07 Nov 2025 10:58:11 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235828514sm458103785a.53.2025.11.07.10.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:58:11 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 13/23] tuna: Fix run command failing to apply BATCH policy
Date: Fri,  7 Nov 2025 13:57:22 -0500
Message-ID: <20251107185732.23992-14-jkacur@redhat.com>
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
2.51.1

