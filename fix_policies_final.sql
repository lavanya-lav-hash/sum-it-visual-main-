-- COMPREHENSIVE POLICY FIX FOR SUM-IT-VISUAL PROJECT
-- This script will completely reset and recreate all RLS policies

-- ===========================================
-- STEP 1: FIX SUMMARIES TABLE POLICIES
-- ===========================================

-- Drop ALL existing policies on summaries table (both admin and user policies)
DROP POLICY IF EXISTS "Only admin can read summaries" ON public.summaries;
DROP POLICY IF EXISTS "Only admin can write summaries" ON public.summaries;
DROP POLICY IF EXISTS "Only admin can update summaries" ON public.summaries;
DROP POLICY IF EXISTS "Only admin can delete summaries" ON public.summaries;
DROP POLICY IF EXISTS "Users can view their own summaries" ON public.summaries;
DROP POLICY IF EXISTS "Users can insert their own summaries" ON public.summaries;
DROP POLICY IF EXISTS "Users can update their own summaries" ON public.summaries;
DROP POLICY IF EXISTS "Users can delete their own summaries" ON public.summaries;

-- Create new user-friendly policies for summaries table
CREATE POLICY "Users can view their own summaries"
  ON public.summaries FOR SELECT TO authenticated
  USING (user_id = auth.uid());

CREATE POLICY "Users can insert their own summaries"
  ON public.summaries FOR INSERT TO authenticated
  WITH CHECK (user_id = auth.uid());

CREATE POLICY "Users can update their own summaries"
  ON public.summaries FOR UPDATE TO authenticated
  USING (user_id = auth.uid())
  WITH CHECK (user_id = auth.uid());

CREATE POLICY "Users can delete their own summaries"
  ON public.summaries FOR DELETE TO authenticated
  USING (user_id = auth.uid());

-- ===========================================
-- STEP 2: FIX STORAGE BUCKET POLICIES
-- ===========================================

-- Drop ALL existing policies on storage.objects for documents bucket
DROP POLICY IF EXISTS "Only admin can read documents" ON storage.objects;
DROP POLICY IF EXISTS "Only admin can write documents" ON storage.objects;
DROP POLICY IF EXISTS "Only admin can update documents" ON storage.objects;
DROP POLICY IF EXISTS "Only admin can delete documents" ON storage.objects;
DROP POLICY IF EXISTS "Users can view their own documents" ON storage.objects;
DROP POLICY IF EXISTS "Users can insert their own documents" ON storage.objects;
DROP POLICY IF EXISTS "Users can update their own documents" ON storage.objects;
DROP POLICY IF EXISTS "Users can delete their own documents" ON storage.objects;

-- Create new user-friendly policies for storage.objects (documents bucket)
CREATE POLICY "Users can view their own documents"
  ON storage.objects FOR SELECT TO authenticated
  USING (bucket_id = 'documents' AND (storage.foldername(name))[1] = auth.uid()::text);

CREATE POLICY "Users can insert their own documents"
  ON storage.objects FOR INSERT TO authenticated
  WITH CHECK (bucket_id = 'documents' AND (storage.foldername(name))[1] = auth.uid()::text);

CREATE POLICY "Users can update their own documents"
  ON storage.objects FOR UPDATE TO authenticated
  USING (bucket_id = 'documents' AND (storage.foldername(name))[1] = auth.uid()::text)
  WITH CHECK (bucket_id = 'documents' AND (storage.foldername(name))[1] = auth.uid()::text);

CREATE POLICY "Users can delete their own documents"
  ON storage.objects FOR DELETE TO authenticated
  USING (bucket_id = 'documents' AND (storage.foldername(name))[1] = auth.uid()::text);

-- ===========================================
-- STEP 3: VERIFY POLICIES ARE ACTIVE
-- ===========================================

-- Enable RLS on both tables
ALTER TABLE public.summaries ENABLE ROW LEVEL SECURITY;
ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

-- Show current policies for verification
SELECT schemaname, tablename, policyname, permissive, roles, cmd, qual, with_check
FROM pg_policies 
WHERE tablename IN ('summaries', 'objects')
ORDER BY tablename, policyname;

