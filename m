Received: from mail.mbosch.me (mail.mbosch.me [65.21.144.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411E01F0994
	for <linux-rt-users@vger.kernel.org>; Sat,  3 Jan 2026 17:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.144.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767461782; cv=none; b=oDu/jwcAgrFCO5toZX9fE3ljvjte4LI1CPCmJy9HoSxSmWLrJlt2V/+yLMEXIgWiStdTmNsNE29O7abvOVe3CsHRZtfqIWllnkMEBy5KJRakrxL2+dTzazWjlIS15hweYS+SMhQoY6DlAxYp89cB65XDoVu1XJA7LP/YvZ+yDkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767461782; c=relaxed/simple;
	bh=Tq61JFprk8lMa/18kVtwAj8ciuVwad/0TnUYiQKBsw4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject; b=bJrfW1QEI23nOtJcKsNcDnZu1IjyiDs7JP8X5WCb2VlfFsxW02jHT+vSbytu4mRNrd/fzpCtMCVLGHiRzODJmM+y89vIldJjVtWtuKTG2E2lksMXKQH6idVsWCUlkdwpRd9sWuAdRgT9pDSMURxF4OWbUmt2+fy2Q+9ydo71azg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mbosch.me; spf=pass smtp.mailfrom=mbosch.me; dkim=pass (1024-bit key) header.d=mbosch.me header.i=@mbosch.me header.b=hoE4m5CO; arc=none smtp.client-ip=65.21.144.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mbosch.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mbosch.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mbosch.me header.i=@mbosch.me header.b="hoE4m5CO"
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mbosch.me; s=mail;
	t=1767461249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xVSRXcnv3hDAjFc8xQKa0qA2Q1thYmjppBHgYkAmZJI=;
	b=hoE4m5CO6yTf+S8oEAo4x2TRXXio8HF+lhCJ3qK491baCbnmdYpCuLm6LZ9XCg6do16CH1
	9IowW6/nDVSO+TdWdDPLZIMo2M07yLadoBBzgmXQ0YLTr+4MaP5FGWlB8N9+vkyM3s9gvG
	sbRfvanTxoKtoc7udT06Zr7f1aQNQYU=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 03 Jan 2026 18:27:28 +0100
Message-Id: <DFF4Q0HTCC47.ZES1ZHKNABXH@mbosch.me>
From: "Maximilian Bosch" <maximilian@mbosch.me>
To: <linux-rt-users@vger.kernel.org>
Subject: Building `rt-tests` v2.9 fails with `Werror=format-overflow`

Hi!

On a GCC 15.2, compiling rt-tests 2.9 fails for me with the following
error:

    rt-tests> src/pmqtest/pmqtest.c: In function 'main':
    rt-tests> src/pmqtest/pmqtest.c:32:21: error: '__builtin___sprintf_chk'=
 may write a terminating nul past the end of the destination [-Werror=3Dfor=
mat-overflow=3D]
    rt-tests>    32 | #define TESTMQ_NAME "/testmsg%d"
    rt-tests>       |                     ^~~~~~~~~~~~
    rt-tests> src/pmqtest/pmqtest.c:644:33: note: in expansion of macro 'TE=
STMQ_NAME'
    rt-tests>   644 |                 sprintf(mqname, TESTMQ_NAME, i);
    rt-tests>       |                                 ^~~~~~~~~~~
    rt-tests> src/pmqtest/pmqtest.c:32:32: note: format string is defined h=
ere
    rt-tests>    32 | #define TESTMQ_NAME "/testmsg%d"
    rt-tests>       |                                ^

I assume this is

* 8 chars for /testmsg
* 10 chars for INT_MAX
* 1 char for a minus (this probably can't happen, but the compiler still
  takes it into account - I assume?)
* One nullbyte

Which can exceed the char pointer of 19 bytes by one byte.

While this is a case that won't happen (given the construction of the
for loop), the compiler still complains because of `-Werror`.

Best
Maximilian
