Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225C52905
	for <linux-rt-users@vger.kernel.org>; Thu, 14 Nov 2024 20:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731617562; cv=none; b=Mkjek4QVHun2gw0QIUL+m6MD7fk9IvcjbhBvVIUOnx1unZ8SDBey+7W0VeXYJ3RWbED+jPLqGiELMEeVAcPZGOhuzhiY7dA9W9y31w62FAsI/ZHsMVISZRiWPzaedIaMsKy5HFj7UQ1G2RNGWmOycLG3bLDsaXC3pqEJ1iLjfqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731617562; c=relaxed/simple;
	bh=4sLfr0+Rwlo3q2oLjB6OjzO6AVmDrP4izn/d43KGLmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SbnlXzLyYyuqnuNqcUu9EG/RebP/vn29atLmkEd1ZWAeqBW1XJGEwmkUU/bSmUovJKXDjaTDrgtP4CWbnarF3Xx2+8ixkJYCCJot05y9sAKNMMprKGnAjTNNhY2WghHsgxXF8elHQAQeLcjJ5lgJMnwz0ztpE5h660JNrOB/aBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbFvMBsG; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbFvMBsG"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b14df8f821so76826685a.2
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Nov 2024 12:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731617560; x=1732222360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=h3lCtt/1/WaFEWAIBh8S8Y7w9VmqO+taYcJYaE6Ue+s=;
        b=kbFvMBsGZ33YbKai1ztcjFLzFPqf79gEauaQGGIRLnN5Yu6b4BFw6z79OotcGjFxX3
         E8yA82KuGFpKJebWqmcMG17H/kCvBvZNuyRcJnnzzHFl7A7rPj9hmw/vhwzXv+xNvqBb
         7981CuCxul+95eO+MqEjDJUkXLdx7Xdfpf0nqi3DgoOlmg6f73HzSlhpFzAHe5ZzQ+9x
         w5vIyZKkbsCyhH5Zll7+blp3PLVPUB3PehOW01CRgLJAEoSea9FxgF3zygvNCIEsj+Rp
         Jnx0+01V2wWmAm64Z5qPQ3GfJZUzzntSsIBNPRBza6IvDKLRJS271nV9FuaixR2Gcslr
         oGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731617560; x=1732222360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3lCtt/1/WaFEWAIBh8S8Y7w9VmqO+taYcJYaE6Ue+s=;
        b=jQW7FXei1yRRwcPi3iLlUTXk6uQrqSL15woNZWAjcoYewxY22nov0wZL+t4b2s1tWs
         fpin8DQixiRB9lOfKiGezAGD6zu6jAjVsPKU/torkYgCH+FIq5yYrmP+QEl+01iJ2yqm
         K4IKNmrWZgh6GedmV72CPB3PoRYlv8/11KL9M13YOoTZzpI43ZWRPfvP4xVOfJtRlhmM
         NP91lX09AOfy7SDLBnNfyKHlcMUAsW/njM3UuFy5YzTx5k76t8qmYbEI7w1IZ2W1cNgo
         tT5QTcOdnnvQVdFVMdAJf/ur3Yz1nHm/MORvyaHx9ekYdXhShRF6ac0OUBC4m4o0NFgp
         bY4A==
X-Gm-Message-State: AOJu0YwLrmBCv1RFJepeETePjV/sVnCMBMZu2gdeEzlxIWzYCClbr6t2
	x7nyeJNCF0GEIuOiJujMVgvDVJicaMkMt/cZIiXVouMSm0fspmBvOX44KA==
X-Google-Smtp-Source: AGHT+IGYNxOaxIXSRAog/mCgY1AJQqx1SOhaJqsW5kGNn4XXsCaJffoPYBAuEF479m8OBY6uJfN9Yg==
X-Received: by 2002:a05:620a:3ac5:b0:7b1:184f:caba with SMTP id af79cd13be357-7b362362b67mr34373785a.40.1731617559611;
        Thu, 14 Nov 2024 12:52:39 -0800 (PST)
Received: from fionn.redhat.com ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35ca51c6csm88203385a.101.2024.11.14.12.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 12:52:39 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>
Cc: Crystal Wood <crwood@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/2] rteval: preface idle-set IDLESTATE with --measurement
Date: Thu, 14 Nov 2024 15:52:30 -0500
Message-ID: <20241114205231.252497-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Setting the idle state belongs to the Group Options for measurement
modules and thus should be prefaced with --measurement just like the
other options in that group. This change fixes that.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rteval/modules/__init__.py b/rteval/modules/__init__.py
index 98276514de95..d60877783670 100644
--- a/rteval/modules/__init__.py
+++ b/rteval/modules/__init__.py
@@ -298,7 +298,7 @@ reference from the first import"""
                                   action = "store_true",
                                   default = config.GetSection("measurement").setdefault("run-on-isolcpus", "false").lower() == "true",
                                   help = "Include isolated CPUs in default cpulist")
-            grparser.add_argument('--idle-set',
+            grparser.add_argument(f'--{self.__modtype}-idle-set',
                                   dest='measurement___idlestate',
                                   metavar='IDLESTATE',
                                   default=None,
-- 
2.47.0

