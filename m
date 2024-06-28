Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B502139A8
	for <linux-rt-users@vger.kernel.org>; Fri, 28 Jun 2024 11:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719572469; cv=none; b=nbHxzFQwWEv5oud9zqpqjHrg2Bw9m55AYygT3mEPwifGeplvFvLjq7CFL8pKN9fhYH6tSB/eoJz1izjhjvZatTg+CjX4G0ga3JYcoMNn1Vjnng2ytOjEDfjs/tbXTXWE6ZysLNDskKiS6oQvW+yr6SVDwhlNAx8FEkZPN3onU60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719572469; c=relaxed/simple;
	bh=1ml1RoPx9m1gMyacgugV+CCp596OO9X0bhnKfEGxFE0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dQnTJeXHELiU6VSh0pP2K7XQwmwd7ORfztbP5mX5FGSdQOHpQjw3RBU7LsinBpXdZNKg6wzJfzZ5Mhi7cVjcYEqtjVMTG6186bhAJnkkJn9xK8ouzK15JxJ1wQrkVWBwpxRBXI8c1rp86MIdAtTgUrpctOCIzHznNk6BlW9l7T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eadWznWL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nZxlyVib; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eadWznWL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nZxlyVib"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719572464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=1v4TXM3pY87XRyDuTBvbqZn/Kap3GfK8s7HffZL0lgk=;
	b=eadWznWLoGoUUUwID0eslpJr4ntJmNOcpMdAMLQ/WO/9QZauGDJmqco4TyyMkyu6KTJWIC
	J6QodYEl7k1zJ6b7drY3z0oXIkZGUDMj7RHko/6gsgbNETp5esDlCxLpzJVJIN8GlbaTlu
	b/ipXb9/i6MkOD3+vQ/V5PB1VAJ1BLArJ5E3OJ4jiN2v3XITR1/FGYWSQ1E7yNyBFlJP7c
	kLCVswe0TZyJpmHWPdk9gDjaYSYr+couyvpMHSep7i5wuBOj/++RIphNG0CFUYOwi/twnW
	KMHFbQ6yOOYp6o2frhpCY1XXmG2EyaJwZYKvCXD34AlpjzkNnGzPmpo1dnQv/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719572464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=1v4TXM3pY87XRyDuTBvbqZn/Kap3GfK8s7HffZL0lgk=;
	b=nZxlyVib5MSxhlSBEEDhRY3NOOFuqCYRSx+NZEFMTxn8umOzTKI9eeJHiM40uOtrKGC0TF
	WSs1ZD/2AKrBUJDw==
To: linux-rt-users@vger.kernel.org
Subject: Mourning Daniel Bristot de Olivera
Date: Fri, 28 Jun 2024 13:01:04 +0200
Message-ID: <871q4hz5zj.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dear community!

Many of you will have already heard the sad news of Daniel passing away
on monday. The academic and the kernel communities have published an
obituary for Daniel on LWN:

        https://lwn.net/Articles/979912/

On behalf of the scheduler and real-time community, I want to ask
everyone for the time being to slow down the patches directed to all the
people in the scheduler, real-time and wider community who have lost a
close friend, so they have time and space to grieve.

Daniel's latest contribution, the deadline server has been put on hold
too and will be worked on when everyone has come to terms with this
heart breaking situation.

Urgent things will be dealt with, but might eventually need a nudge.

Thanks in advance for your understanding and respect!

       Thomas
