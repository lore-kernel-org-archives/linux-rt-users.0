Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB561EB27
	for <linux-rt-users@vger.kernel.org>; Wed, 18 Oct 2023 19:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="gwHg/kTP"
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AC219A;
	Wed, 18 Oct 2023 12:49:07 -0700 (PDT)
Received: from smtp.gmail.com (1.general.jsalisbury.us.vpn [10.172.66.188])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id EE37D41667;
	Wed, 18 Oct 2023 19:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1697658543;
	bh=Gd64AQOlYW0cO+GJIqYClb0fmWxzvQzaoJzI+NqnDfE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=gwHg/kTP4yko3u2zpm9MYF3sgVOBWx5/6Fpk3Znq6zOoxGFpY/z2P/dLijS4vgLfT
	 XHrS8RAEeliKarUyAjIyfpU6+LS1Ht00cXej3L8mjHB1bSp2JEeH08THPCjvy7LSoP
	 Osmr/iQ4Jf4ggRClne45qDgTXnACqzbwzQJ0z3qTMq7bKdobya4dalkASrQYvIHo6x
	 Hnqy7cyFQ50rofpLwxk6ZjTa3abX221nxO+W2PRe7lUnMBdOAj0S5ourJA9jEPqF/f
	 5HcdnCp6eLV4tE/fG5yZUvu9daxHI61+bWaOzYgtVLgN+q6XeTLJq84+ygGMVXOf3C
	 iIT1pFbznSiaQ==
From: Joseph Salisbury <joseph.salisbury@canonical.com>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	Pavel Machek <pavel@denx.de>,
	Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: [PATCH RT 12/12] Linux 5.15.133-rt70
Date: Wed, 18 Oct 2023 15:48:33 -0400
Message-Id: <20231018194833.651674-13-joseph.salisbury@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018194833.651674-1-joseph.salisbury@canonical.com>
References: <20231018194833.651674-1-joseph.salisbury@canonical.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v5.15.133-rt70-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Joseph Salisbury <joseph.salisbury@canonical.com>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index 65189810797f..f36b5d418dd8 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt69
+-rt70
-- 
2.34.1

