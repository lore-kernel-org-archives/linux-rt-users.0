Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643942773E9
	for <linux-rt-users@vger.kernel.org>; Wed, 17 Sep 2025 16:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758127764; cv=none; b=QcNzd65HgEvZswG3jIQ72esuP7xEsECHFFfq7k/Y9zTT+wYaWlDjkG3Wlh7MHpN263EGc48EQFtatKUnqLd74VS2sKbDPokotH2p/+0ghH6Vxix0awW+46/PDfA6fytrt8/QNHEHfLZmOCVH4B4LoFBNeLxmWF1VPXmpcfJT/8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758127764; c=relaxed/simple;
	bh=HvoU4zDNaqFl329ojXFUk8oIRip3zFiPr59JU4Wysz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sclpbYifslnaVIKCRLiLXsK62SgW0cQAlWJAe51AoL5wGQ/ZQbULd5mXKDYwSJAK7QMtrceAV8WhFesOrnuIY4uoMp0ShnwokPIiwAqj23oM62z+ZuDgc+n91AaW2liGd8V6LGDFYpvSh3odwxZAe11WYzrgN3NI3seUOaiYfeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dx23DKLo; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dx23DKLo"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b7a40c7fc2so480321cf.2
        for <linux-rt-users@vger.kernel.org>; Wed, 17 Sep 2025 09:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758127762; x=1758732562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+9PM2dqVs194jWxsxuM6nZhE2oAjqozZ4eNO4TLqzRI=;
        b=dx23DKLoEu1LMX0P4jNNNLQAHFKQOQn49HSTZU86d617Pvf1uLHKd4LlvVKkLzH8tK
         Ud2BL6eYbUphAeJngq40Be+tpek70y1SPnyeYo9ZDGDILb+uG4o9kmqxzEPqIbVB8p24
         IrGet8sIrRf+riRB0t1PQnwb3gUMupSvE6e7r8BkuGY7XYfjmQag8NK7cGYTvwhFLMMA
         NO6NU1NdtFVk6Cw73Fg9wx2Y6lXsRpNchDhkUC2vP+gIApCjJF8ZFf8M7qnk3ZBsWHNB
         l2gegWhN6C+rmtCuA7oHrNF8QLevI8EZkXsKZO2yMW/Kga90jUPenglY/GKr+bBoFr94
         zklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758127762; x=1758732562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9PM2dqVs194jWxsxuM6nZhE2oAjqozZ4eNO4TLqzRI=;
        b=CQnSbTsHdVzvllHR9yaCx3zZ/sWVbS7oAux6/r3cOnvz4JNYRq6UTFIsiwaMpOAIET
         eY6kPWT+w62w44dOMsQV8rKZRuo+tMu7w8vBS1+AL1tVNtApI3il5jbW3eW/Sl/rxgv6
         ej5Ouc8HsSd372xqO5JiVJWI5ZtKNz1mCFp0L+i4Iil2pI1qjsaO0kAAvwj1PXJEKUTP
         iS7P/sAfWSIEu857HYJ3yWe1jOQ0gA4wVcIHuwfDxd/G3SzJA7qUSyY4BAl15zRVrbvi
         J/TYWpe+S2TePbUzxsHlY5v1N1MR4QrLsuIcyRHBNWuObQmZphTdMNZ62EyYRNGdm2GY
         wIrA==
X-Gm-Message-State: AOJu0YwtdFLNIIOXjpvyu1d1uhkGvFWJ3iTd/I1Zw3q9l0jJ/tmPr8sH
	yrtEwngqDSNd7lUwRGHYWIrzl+gEDgjd71tAxdFLfFW79MD26O6NEQQGZMSZwiwi
X-Gm-Gg: ASbGncs4gfomWXzftNRJq6mSUHU7jBcUOYo/SubVVMqG5NHBDwxChvJfF6HHT0xK+EQ
	Ek5DKNoGSkVn6KZn6WgAguxZQ1MRuAj859UPWihdJdjdRtQ99qDquWv615wQ0cu8chdh2ovqXLu
	JcvtiMX7qFuZPZE2izpbqizvMuLbspJzwnJ/g3CgtxWgYB6WNYxAIxdPLkudQ+5icEXJ/mE3SHe
	kT7To9HnWp8NLW2pDzStlo7LPQq2wc3dJSXrMl6kpvlTY6f3nyUKYriWXzDwS6gAm13Z/ABPBUm
	kfgHVnKcFzYfndSRwVDU1GsUWPKbgb0uSAeEuVMHnBQ1y/KnQpy7A0AWDhCZy9qOIIsoGFZ+8L+
	FdoVHDPsWexAcUVUrrtMjwQnn93Vp+drxXR64NAg/NbJOLqX6PA9gmcl9O+9dXvtmtLAxngUJp0
	xbqPrkjvK3l0yA
X-Google-Smtp-Source: AGHT+IElM4YJAfGWJKDQALKhjORAobuSH0f8/+XVtaNGuVcvnuiIBCZwu2I1LC7qvR5lPS1c5QLOYA==
X-Received: by 2002:a05:622a:491:b0:4b5:edd3:ddd6 with SMTP id d75a77b69052e-4ba6c6b42a5mr30687951cf.82.1758127761825;
        Wed, 17 Sep 2025 09:49:21 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0604w-grc-06-70-50-116-186.dsl.bell.ca. [70.50.116.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4bda1ccc19dsm1206161cf.14.2025.09.17.09.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 09:49:21 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: John Wyatt <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH] tuna: Add -U and -K to the spread command
Date: Wed, 17 Sep 2025 12:49:00 -0400
Message-ID: <20250917164900.69529-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 4e10e5b34593052e6ce4a166796b10c72f978efd
add the feature
	-U, --no_uthreads	Operations will not affect user threads
	-K, --no_kthreads	Operations will not affect kernel
threads

to the move command

This also works for the spread command but the arguments need to be
added. Without this you also get an
AttributeError: 'Namespace' object has no attribute 'uthreads'

Fix this by adding the options to the spread group for argparse.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna-cmd.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tuna-cmd.py b/tuna-cmd.py
index d0a3e6b7dbf8..9f5ce918054d 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -183,6 +183,8 @@ def gen_parser():
     spread_group.add_argument('-N', '--nohz_full', **MODS['nohz_full'])
     spread.add_argument('-t', '--threads', **MODS['threads'])
     spread.add_argument('-q', '--irqs', **MODS['irqs'])
+    spread.add_argument('-U', '--no_uthreads', **MODS['no_uthreads'])
+    spread.add_argument('-K', '--no_kthreads', **MODS['no_kthreads'])
 
     priority.add_argument('priority', **POS['priority'])
     priority.add_argument('-t', '--threads', **MODS['threads'], required=True)
-- 
2.49.0

