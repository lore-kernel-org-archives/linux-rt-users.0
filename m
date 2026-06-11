Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755303164C5
	for <linux-rt-users@vger.kernel.org>; Thu, 11 Jun 2026 20:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781210335; cv=none; b=lbchXjMhk5NjGto4UU9tHyyEK0sAR0gu0yaKAWHAncxT3gWTOnvJZS+K/uaydtFnhVFUTP1eL3JX6XEesXYfYjnnybCK7ljyvlyV2Z3ABXi/uGMVN5ee8+ZXDcFjokBwavswo7IKSMso+IU1yEFzB6GjZIanPfGCby3YteQC7SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781210335; c=relaxed/simple;
	bh=5O7fNmD647TKzMm/2Xt7fTFr9jQuQ4qoPq7YyZDPxQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/e6w7PbWVIKIT26X4MXR4Y0YHdd4JP6c4bjeg0Q+19L5bPMNMxdxDqqRzmVhzZ7kf+rVSBO/T/Am2KynUFFb5F0mTfIDR5GRT+OSaghpe1r1pIiFC6smiaV1P5lBtiviTm1LUkBy5zI6BU8PxB3E2tpyfPw/MfTBiKX+QkB10g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZK/BpWeA; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZK/BpWeA"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5175cb5946dso1443851cf.0
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Jun 2026 13:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781210331; x=1781815131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uh9itD4UuTvkslVFLT4oG4IJZTe+wg6rd6MLViNj2uk=;
        b=ZK/BpWeALR0k485qSzXAroiIR6vbxx/aitxTZm5PeApIzrWXJ/yzFzTWCo7F/MTU5X
         RcAOdIqh+FHRE0y8HvnzdcwQRIWo+ENW3WwUZiV1IRE7E6Bk3vLWvJHu/VlNBqg9RBwV
         y6Rqxm2ogf+ohWQ7uiwxVDfWWBZtbqm9Eqb0GsucTjLybgSKx1pyojdSPIC3YkJSiXGV
         ZH7PyiMxdTS+r2Mx7FaXBO5LiwRflPbSZjsIYhZ7EfxhyKAXixn2S3A993p7f4neNQTk
         4RfWiL7vYDBoU7jqnUTqX/o014xMWw0gFFXdKmjGgBJqs7fWXwp3kcRVj4BvAZb1bxr1
         jzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781210331; x=1781815131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uh9itD4UuTvkslVFLT4oG4IJZTe+wg6rd6MLViNj2uk=;
        b=kddm9m7BRbstCpQwcvp1Ae7vYSWU1AQTPoSgF8e76PqOctwkvS63Hv9aUUfo3WlDJj
         z/Z76cBnA+zJ64Su0AQZe09V+LB+q0OgeqPTViHafbOfFc8CmNUUTPr9gPI/sHA2agWg
         RHkYGIVMFlHSi8uzm2k/Pj4bHek9aQ40bGl2UYw1YSFCytSGzNekOPkyds4BgS8Maen9
         wEQW2GgEHINZO8LqqxVnEumFaqCWAnyIMdQnbek6oHpZtdGxEf75AjdvM6OMfQF7MoqH
         /+7vrJiT6A7TvYKHDJL6oUM9jVnhN9uFwEFzltVs1cKQk/Chlgyo266TZrIHK9iBgVG8
         jQ5Q==
X-Gm-Message-State: AOJu0YydG4AJq4T5SHsCN6cTS5ScTtoNhOsmDz5duQZEMZbfWM9rKzGI
	ix9tXTInMDN3oFgukAzEUuO49+P7RjZYAmagZ0nIb+hbm6LYNEIo17Qvhhw7VQ==
X-Gm-Gg: Acq92OGU8ATRtu6ZmijH6c8la5rqt/FZxWBccL+2znHcI9wZ4fHeoGz1VQ2HkqrARlB
	Kg8My2BnsE1spmU8o6OaaQ/VXb/3ho2QWAf0PR4oUY/bc5RxAqom/Iiqltlbp47NvAjs78nqePp
	/AQ0ft9AXGOuXfmojgFsDNP03NdpsBST6f1UA7F6Td4Aqep98YN6CSVgUk7WPfaGdnjndODBGRQ
	nIol0CLgAXgQAlMz18mqt5y6up6FqX6ap/k5yEM7OERxNtj8zq+gCWhzaJntPyeNvPLHcRaZZ3H
	mByPytNZ9Zwel6zTzyaQpTtJT8lb2F7cH9ovHXVIPYA8q/Eaz967ldVUdnfCpY04P/lgbycoEo7
	VckOEyNP+vWjkge/WZoj5rn1Y9BK/LNIzyyFCsS55THirt37ralOy5f9xhLu0nPl+WVgJYJigRD
	l/STklTn1lslLcvpPiqCSB7qzcieuA3P77aMUytTxfhRNPL6DRMtUlE2h4C25MpDmdfU+zvyp1Z
	dloQ3XEkT5fDYflZis=
X-Received: by 2002:a05:622a:1c1b:b0:517:9206:10fd with SMTP id d75a77b69052e-517ede2c5ebmr71399211cf.16.1781210331140;
        Thu, 11 Jun 2026 13:38:51 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb642541sm3214051cf.10.2026.06.11.13.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 13:38:50 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>
Subject: [PATCH 1/5] tuna: Replace bare except clauses with specific exception types
Date: Thu, 11 Jun 2026 16:38:28 -0400
Message-ID: <20260611203832.176805-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611203832.176805-1-jkacur@redhat.com>
References: <20260611203832.176805-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace all bare except clauses in tuna-cmd.py with specific exception
types for better error handling and debugging. This improves code quality
by being explicit about what errors are being caught.

Changes:
- inet_diag import (line 75): Use ImportError
- ps_show_sockets (lines 298, 305): Use OSError for process death cases
- irq users lookup (line 357): Use KeyError, ValueError, LookupError
- IRQ parsing (line 418): Use ValueError, KeyError
- socket iteration (line 457): Use OSError, StopIteration
- driver lookup (line 500): Use ValueError
- thread regex (line 571): Use re.error

All existing unit tests pass after these changes.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna-cmd.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tuna-cmd.py b/tuna-cmd.py
index 6208bd116cea..54f0666fa1bb 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -72,7 +72,7 @@ def add_handler(loglevel, tofile=False):
 try:
     import inet_diag
     have_inet_diag = True
-except:
+except ImportError:
     have_inet_diag = False
 
 # FIXME: ETOOMANYGLOBALS, we need a class!
@@ -295,14 +295,14 @@ def ps_show_sockets(pid, ps, inodes, inode_re, indent=0):
     dirname = f"/proc/{pid}/fd"
     try:
         filenames = os.listdir(dirname)
-    except:  # Process died
+    except OSError:  # Process died
         return
     sindent = " " * indent
     for filename in filenames:
         pathname = os.path.join(dirname, filename)
         try:
             linkto = os.readlink(pathname)
-        except:  # Process died
+        except OSError:  # Process died
             continue
         inode_match = inode_re.match(linkto)
         if not inode_match:
@@ -354,7 +354,7 @@ def ps_show_thread(pid, affect_children, ps, has_ctxt_switch_info, sock_inodes,
                     users[users.index(u)] = "%s(%s)" % (
                         u, ethtool.get_module(u))
             users = ",".join(users)
-        except:
+        except (KeyError, ValueError, LookupError):
             users = "Not found in /proc/interrupts!"
 
     ctxt_switch_info = ""
@@ -415,7 +415,7 @@ def ps_show(ps, affect_children, thread_list, cpu_list,
                             continue
                     else:
                         in_irq_list = True
-                except:
+                except (ValueError, KeyError):
                     pass
             elif not thread_list:
                 continue
@@ -454,7 +454,7 @@ def load_socktype(socktype, inodes):
     while True:
         try:
             s = idiag.get()
-        except:
+        except (OSError, StopIteration):
             break
         inodes[s.inode()] = s
 
@@ -497,7 +497,7 @@ def find_drivers_by_users(users):
         try:
             idx = u.index('-')
             u = u[:idx]
-        except:
+        except ValueError:
             pass
         if u in nics:
             driver = ethtool.get_module(u)
@@ -568,7 +568,7 @@ def threadstring_to_list(threadstr):
             ps = procfs.pidstats()
             try:
                 thread_list += ps.find_by_regex(re.compile(fnmatch.translate(s)))
-            except:
+            except re.error:
                 thread_list += ps.find_by_name(s)
     return thread_list
 
-- 
2.54.0

