Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B3023C8DB;
	Mon,  3 Mar 2025 22:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741042386; cv=none; b=FaCXLzm5Ok/necVs1s26yXppl+9+SHJWC6KKeRGxuH2cr7rvfGeIBy25y5O73pT6zjJogA25ueSFuf0uy0uPwI3aFvX/30jouKXGVGQespjjR1//8+bXsZujWaYq8BuYLXUUFXPKvQ+8kcI/DEjvQDd0dkXrm7h2AwPJpiRkdC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741042386; c=relaxed/simple;
	bh=coceC9UTK61k9swoVPzDZ3N9VLAgHoOsmfQVKBqVgaE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E9K3uh6j/e8vuX/lOqdOGCEdFI4lW2cygaM6wDI7OZMPsCEnunqoJYmpldsJOJSn9+u4OBpBvODYK9yFpuNuNd4j+NpytXBKM3qdLvBnQ5K68BkyAKepF2BDLESqpCUMLa9FHpJ2J3nzcNyjCVVE4+WjG6o3BX3B0fFK7/6/acw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRkXeNp1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRkXeNp1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316BEC4CEEE;
	Mon,  3 Mar 2025 22:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741042386;
	bh=coceC9UTK61k9swoVPzDZ3N9VLAgHoOsmfQVKBqVgaE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NRkXeNp1y71VfTZ7PoGhcVSPzGEmdoX4EHCW2V/ZdsZZk1LM98PlncFhmIffhbOzC
	 hqfwKoUFoDvrgT+eIRUQ+RtQU9Mwdl4lSA8Vuk2Clo275vu6HhmsOrqPpmpbygaBGM
	 9DCDTpjUOCfdHTbf9z4GxnJ6gPoQUle1msUIG5boi6KWdxIgV9hn3paOK/OeaT55pX
	 IcPgt0pD/OJBlwV75kSjSJ2pO8N61ht8GJtleMyBV316u0D9wSL4AEm4b9YiBtRgoK
	 faNPH5Pqz8i9ZXVm/KF6PKUhaOpbz3f2XefFuer8DOb8UMrT/7Z8f1sN3hO864AKMg
	 OwppXA/S8GUGg==
From: zanussi@kernel.org
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <wagi@monom.org>,
	Clark Williams <williams@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Joseph Salisbury <joseph.salisbury@oracle.com>,
	Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 4/4] Linux 5.4.290-rt96-rc1
Date: Mon,  3 Mar 2025 16:52:58 -0600
Message-ID: <7895cdb7a6e92feeeefab88d74b48f20b0b9fd1e.1741042351.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741042351.git.zanussi@kernel.org>
References: <cover.1741042351.git.zanussi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tom Zanussi <zanussi@kernel.org>

v5.4.290-rt96-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index 5a28f0a65d160..02183db2728ee 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt95
+-rt96-rc1
-- 
2.43.0

